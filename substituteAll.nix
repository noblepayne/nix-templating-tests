{
  stdenv,
  lib,
  runtimeShell,
  # args
  message,
  ...
}:
stdenv.mkDerivation {
  name = "substituteAll";
  src = ./.;
  inherit runtimeShell message;
  installPhase = ''
    mkdir -p $out/bin
    substituteAll templates/substituteAll.sh $out/bin/substituteAll
    chmod +x $out/bin/substituteAll
  '';
}
