#!/usr/bin/env bash

# automatically called inside nix dev env
# serves as background daemon to respond to calls for wpilib applications
# this isn't exactly needed, and technically overly complex

# nix env gets mad without this line, it's not exported soo not the end of the world
LC_ALL="en_US.UTF-8"

rmpipe(){
	if [[ -r "$PIPE_LOCATION" ]]; then
		# TODO: make this more safe
		rm "$PIPE_LOCATION"
	fi
}
trap "rmpipe" EXIT

errout(){
	local errtxt errcode
	case $# in
		0)
			errtxt="reason not provided"
			errcode=1
			;;
		1)
			errtxt="$1"
			errcode=1;
			;;
		*)
			errtxt="$1"
			errcode="$2"
			;;
	esac
		
	echo "exiting: $errtxt" >&2
	
	exit "$errcode"
}

if [[ "$SHLVL" -le 1 ]]; then
	errout "called outside of the correct nix develop env" 
fi


if [[ ! -r ./daemon.cfg ]]; then
	errout "config not found" 
fi

# read config as bash txt @ global scope
# this isn't secure, so be careful with shared/edited config
. ./daemon.cfg

if [[ ! -v ENABLED_PROGRAMS ]] && [[ ! -v PIPE_LOCATION ]]; then
	errout "config not properly read"
fi


# this is overly verbose, but also clear
read_fifo(){
	local pipe_reply
	read -r <"$PIPE_LOCATION"
	echo -en "$REPLY"
}
# don't need a write function since that's done in the .desktop

process_kw(){
	local v
	for v in "${ENABLED_PROGRAMS[@]}"
	do
		if [[ "$v" == "$1" ]]; then
			nixGL "$v"
		fi
	done
}

primary_loop(){
	local pipe_reply

	pipe_reply="$(read_fifo)"

	process_kw "$pipe_reply"

	primary_loop
}

mkfifo "$PIPE_LOCATION"

primary_loop

errout "EOF" 0
