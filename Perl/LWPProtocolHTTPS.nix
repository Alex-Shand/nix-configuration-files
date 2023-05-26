with import <nixpkgs> {};
with perlPackages;

buildPerlPackage {
  pname = "LWP-Protocol-https";
  version = "6.10";
  src = fetchurl {
    url = "mirror://cpan/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.10.tar.gz";
    sha256 = "cecfc31fe2d4fc854cac47fce13d3a502e8fdfe60c5bc1c09535743185f2a86c";
  };
  buildInputs = [ TestRequiresInternet ];
  propagatedBuildInputs = [ IOSocketSSL LWP MozillaCA NetHTTP ];
  meta = {
    homepage = "https://github.com/libwww-perl/LWP-Protocol-https";
    description = "Provide https support for LWP::UserAgent";
    license = with lib.licenses; [ artistic1 gpl1Plus ];
  };
}
