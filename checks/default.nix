{
  self,
  system,
  pre-commit-hooks,
  pkgs,
}:

let
  # Function to create a check for a template by running `nix flake check`
  checkTemplate =
    name: template:
    let
      checkName = "${name}-template-check";
    in
    {
      name = checkName;
      value =
        pkgs.runCommand checkName
          {
            buildInputs = with pkgs; [
              nix
              cacert
            ];
          }
          ''
            set -x  # Enable verbose output
            # Use `--print-build-logs` for verbose output during CI runs
            nix flake check --print-build-logs ${template.path} -vvv > $out 2>&1
            set +x  # Disable verbose output
          '';
    };

  # Generate a list of checks for all templates in `self.templates`
  templateChecks = pkgs.lib.attrsets.mapAttrs' (
    name: template: checkTemplate name template
  ) self.templates;

in
templateChecks
// {
  # Pre-commit check configuration using hooks
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      nil.enable = true;
      nixfmt-rfc-style.enable = true;
      prettier = {
        enable = true;
        settings = {
          prose-wrap = "always";
        };
      };
    };
  };
}
