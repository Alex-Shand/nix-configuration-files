with import <nixpkgs> {};

buildPerlPackage rec {
  name = "Linux-Proc-Mounts-0.02";
  src = fetchurl {
    url = "mirror://cpan/authors/id/S/SA/SALVA/${name}.tar.gz";
    sha256 = "0d09da53d96af5c8dd640ca7256d5bed96a5dbeceda2d4cd1f295df709a79ccc";
  };
}
