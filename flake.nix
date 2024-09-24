{
  description = "Nix Flake Templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      pre-commit-hooks,
    }:
    {
      # Templates this flake provides
      templates = import ./templates { };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {

        # Formatter for this flake
        formatter = pkgs.nixfmt-rfc-style;

        # Add new checks in `/checks` (pre-commit-hooks are setup)
        checks = import ./checks {
          inherit
            self
            system
            pre-commit-hooks
            pkgs
            ;
        };

        # Development shell with necessary tools
        devShells =
          let
            pre-commit-check = self.checks.${system}.pre-commit-check;
          in
          {
            default = pkgs.mkShell {
              packages = pre-commit-check.enabledPackages ++ [
                self.formatter.${system}
                # Add other dependencies here
              ];
              inherit (pre-commit-check) shellHook;
            };
          };
      }
    );
}
