with import <nixpkgs> {};
with python3.pkgs;

buildPythonPackage rec {
  pname = "dominate";
  version = "2.3.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0s9s9j9xmhkzw7apqx170fyvc0f800fd4a5jfn8xvj9k6vryd32b";
  };

  doCheck = false;
}
