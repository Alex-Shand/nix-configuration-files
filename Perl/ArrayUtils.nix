with import <nixpkgs> {};

buildPerlPackage rec {

  name = "Array-Utils-0.5";

  src = fetchurl {

    url = "mirror://cpan/authors/id/Z/ZM/ZMIJ/Array/${name}.tar.gz";

    sha256 = "89dd1b7fcd9b4379492a3a77496e39fe6cd379b773fd03a6b160dd26ede63770";

  };

}
