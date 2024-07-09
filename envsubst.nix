{
  stdenv,
  lib,
  runtimeShell,
  gettext,
  # args
  message,
  ...
}:
stdenv.mkDerivation {
  name = "envsubst";
  src = ./.;
  inherit runtimeShell message;
  nativeBuildInputs = [gettext];
  installPhase = ''
    mkdir -p $out/bin
    envsubst < templates/envsubst.sh > $out/bin/envsubst
    chmod +x $out/bin/envsubst
  '';
}
