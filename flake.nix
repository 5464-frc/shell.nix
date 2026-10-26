{
  description = "FRC 5464 Nix Flake-based dev env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      packages = with pkgs; [
        mise
      ];

      shellHook = ''
      export LC_ALL="en_US.UTF-8"
      export PS1="(nix)::$PS1"
      . ./pipe
	      '';
    };
  };
}
