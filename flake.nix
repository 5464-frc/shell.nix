{
  description = "FRC 5464 Nix Flake-based dev env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    frc.url = "github:frc4451/frc-nix";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, frc, nixgl,... }: 
  let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = 
    let
      pkgs = import nixpkgs { inherit system; };

      frcPackages = with frc.packages.${system}; [
        advantagescope
        datalogtool
        elastic-dashboard
        firstdriverstation
        glass
        outlineviewer
        pathplanner
        pathweaver
        roborioteamnumbersetter
        robotbuilder
        shuffleboard
        smartdashboard
        sysid
        # vscode-wpilib
        wpical
        wpilib-utility
        choreo
      ];
    in pkgs.mkShell {
      packages = [
        #TODO: make vscode work
        # pkgs.vscode-with-extensions
        nixgl.packages.${system}.nixGLDefault
      ] ++frcPackages;

      shellHook = ''
      export LC_ALL="en_US.UTF-8"
      export PS1="(nix)::$PS1"
      bash daemon.bash
	      '';
    };
  };
}
