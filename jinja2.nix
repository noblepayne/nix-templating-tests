{
  stdenv,
  lib,
  runtimeShell,
  writeText,
  jinja2-cli,
  # args
  message,
  ...
}: let
  templateArgs = writeText "templateArgs" (builtins.toJSON {inherit runtimeShell message;});
in
  stdenv.mkDerivation {
    name = "jinja2";
    src = ./.;
    nativeBuildInputs = [jinja2-cli];
    installPhase = ''
      mkdir -p $out/bin
      jinja2 templates/jinja2.sh --format json ${templateArgs} > $out/bin/jinja2
      chmod +x $out/bin/jinja2
    '';
  }
