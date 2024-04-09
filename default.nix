with import <nixpkgs> {} ;
{ branch ? "master" }:

let
  # Fetched from https://api.citra-emu.org/gamedb
  # Please make sure to update this when updating citra!
  compat-list = fetchurl {
    name = "citra-compat-list";
    url = "https://web.archive.org/web/20231111133415/https://api.citra-emu.org/gamedb";
    hash = "sha256-J+zqtWde5NgK2QROvGewtXGRAWUTNSKHNMG6iu9m1fU=";
  };
in {
  master = qt6Packages.callPackage ./generic.nix rec {
    pname = "citra";
    version = "r0c2f076";

    src = fetchFromGitHub {
      owner = "PabloMK7";
      repo = "citra";
      rev = "r0c2f076";
      sha256 = ""; # Will get hash from error message
      fetchSubmodules = true;
    };

    inherit branch compat-list;
  };
}.${branch}
