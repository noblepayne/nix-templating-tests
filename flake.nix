{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = ["x86_64-linux"];
    pkgsBySystem = nixpkgs.lib.getAttrs supportedSystems nixpkgs.legacyPackages;
    forAllSystems = fn: nixpkgs.lib.mapAttrs fn pkgsBySystem;
  in {
    formatter = forAllSystems (system: pkgs: pkgs.alejandra);
    packages = forAllSystems (
      system: pkgs: {
        substituteAll = pkgs.callPackage ./substituteAll.nix {message = "hello from substituteAll";};
        envsubst = pkgs.callPackage ./envsubst.nix {message = "hello from envsubst";};
        nixTmpl = pkgs.callPackage ./nixTmpl.nix {message = "hello from nixTmpl";};
        jinja2 = pkgs.callPackage ./jinja2.nix {message = "hello from jinja2";};
        default = pkgs.writeShellScriptBin "runTests" ''
          for version in substituteAll envsubst nixTmpl jinja2; do
            echo $version
            nix run .#$version
            echo
          done
        '';
      }
    );
  };
}
