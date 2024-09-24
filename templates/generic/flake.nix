{
  description = "Generic Nix Flake Template with Pre-Commit Hooks and Development Shell";

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
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # Import your custom library if needed
        lib = import ./lib.nix { inherit (pkgs) lib; };

        # Define packages in `packages.nix`
        packages = import ./packages.nix { inherit pkgs; };

        # Formatter for this flake
        formatter = pkgs.nixfmt-rfc-style;

        # Add new checks in `/checks` (pre-commit-hooks are setup)
        checks = import ./checks {
          inherit system pre-commit-hooks pkgs;
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
