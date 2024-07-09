{
  stdenv,
  lib,
  runtimeShell,
  writeText,
  # args
  message,
  ...
}: let
  # helper to use nix-native string interpolation as a template
  nixTmpl = file: args: let
    # build list of arg names suitable for kwarg destructuring: `arg1, arg2, arg3`
    fnKwargs = lib.concatStringsSep ", " (builtins.attrNames args);
    # build nix file `{arg1, arg2}: ''<body of template file>''`
    # this creates a file that defines a function that returns a string that
    # interpolates the function args.
    rawText = writeText "temptext" "{${fnKwargs}}: ''${builtins.readFile file}''";
  in
    writeText "templatedText" (import rawText args);
  # templated output
  templatedText = nixTmpl ./templates/nixTmpl.sh {inherit runtimeShell message;};
in
  stdenv.mkDerivation {
    name = "nixTmpl";
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin
      cp ${templatedText} $out/bin/nixTmpl
      chmod +x $out/bin/nixTmpl
    '';
  }
