# frc.env

nix develop based daemon for wpilib utilities 

## assumed:
- laptop is running a stable GNU Debian-based distribution
- nix is installed (see: [https://nixos.org/download/#nix](https://nixos.org/download/#nix))

## how it works:
- [./daemon.bash](./daemon.bash) is called *inside* the nix development shell
- using named pipes (see `man mkfifo`), it accepts program names from the location specified in config
- nixGL uses the system OpenGL implimentation
- to run a given program, you only need to write its script name (as is declare by frc-nix) to the pipe

## notes:
- there are significantly better ways to do this, but the end result of this is functional with minimal overhead / background ram usage.
- relies heavily on the great work done by team 4451 at [https://github.com/frc4451/frc-nix](https://github.com/frc4451/frc-nix)
- yearly robot code can be stored in [./code]. contents of that directory wil be ignored by git
- [./LICENSE](./LICENSE) applies specifically to the contents of this directory. license may vary from yearly robot code and used software

## "compilation":
as all scripting is done in nix/bash, nothing's actually ever compiled. [./compile.bash](./compile.bash) can be used to create a systemd service, as well as associated desktop files. result is stored in [./output](./output). the contents thereof are ignored by git
