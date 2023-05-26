with import <nixpkgs> {};
with perlPackages;

buildPerlPackage {
    pname = "libwww-perl";
    version = "6.55";
    src = fetchurl {
      url = "mirror://cpan/authors/id/O/OA/OALDERS/libwww-perl-6.55.tar.gz";
      sha256 = "c1d0d3a44a039b136ebac7336f576e3f5c232347e8221abd69ceb4108e85c920";
    };
    buildInputs = [ HTTPDaemon TestFatal TestNeeds TestRequiresInternet ];
    propagatedBuildInputs = [ EncodeLocale FileListing HTMLParser HTTPCookies HTTPDate HTTPMessage HTTPNegotiate LWPMediaTypes NetHTTP TryTiny URI WWWRobotRules ];
    meta = {
      homepage = "https://github.com/libwww-perl/libwww-perl";
      description = "The World-Wide Web library for Perl";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
}
