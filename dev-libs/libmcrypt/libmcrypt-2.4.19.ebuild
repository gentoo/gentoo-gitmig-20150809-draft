# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Christian Rubbert <crubb@xrc.de>

S=${WORKDIR}/${P}
DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
SRC_URI="ftp://mcrypt.hellug.gr/pub/mcrypt/libmcrypt/${P}.tar.gz"
HOMEPAGE="http://mcrypt.hellug.gr/"

DEPEND="virtual/glibc"

src_compile() {

	econf --host=${CHOST} \
		--disable-posix-threads || die
		
	# PHP manual states to disable posix threads, no further explanation given, but i'll
	# stick with it :) (Source: http://www.php.net/manual/en/ref.mcrypt.php)

	emake || die
}

src_install () {
	
	dodir /usr/{bin,include,lib}
	
	einstall || die

	dodoc AUTHORS COPYING INSTALL KNOW-BUGS NEWS README THANKS TODO doc/README.* doc/example.c
}
