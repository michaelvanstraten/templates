{ ... }:
{
  default = {
    path = ./generic;
    inherit (import ./generic/flake.nix) description;
  };
}
