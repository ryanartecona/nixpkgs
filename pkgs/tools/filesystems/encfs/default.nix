{ stdenv, fetchFromGitHub, autoreconfHook, boost, fuse, openssl, perl
, pkgconfig, rlog }:

let version = "1.8.1"; in
stdenv.mkDerivation {
  name = "encfs-${version}";

  src = fetchFromGitHub {
    sha256 = "1cxihqwpnqbzy8qz0134199pwfnd7ikr2835p5p1yzqnl203wcdb";
    rev = "v${version}";
    repo = "encfs";
    owner = "vgough";
  };

  buildInputs = [ boost fuse openssl rlog ];
  nativeBuildInputs = [ autoreconfHook perl pkgconfig ];

  configureFlags = [
    "--with-boost-serialization=boost_wserialization"
    "--with-boost-filesystem=boost_filesystem"
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = https://vgough.github.io/encfs;
    description = "Provides an encrypted filesystem in user-space via FUSE";
    license = licenses.lgpl2;
    maintainers = with maintainers; [ nckx ];
  };
}
