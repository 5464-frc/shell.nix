# frc.env

nix shell/general environment for programming

## assumed:
- laptop is running a stable GNU Debian-based distribution
- nix is installed (see: [https://nixos.org/download/#nix])


## notes:
- a JDK isn't provided at the nix shell level. considering this varies from year-to-year, it's contained in mise (which is in the shell)
- relies heavily on the great work done by team 4451 at [https://github.com/frc4451/frc-nix]
- yearly robot code can be stored in [./code]. contents of that directory wil be ignored by git
- [./LICENSE] applies specifically to the contents of this directory. license may vary from yearly robot code and used software
