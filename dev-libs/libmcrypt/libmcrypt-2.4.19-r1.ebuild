# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Christian Rubbert <crubb@xrc.de>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.4.19-r1.ebuild,v 1.1 2002/05/05 09:26:38 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
SRC_URI="ftp://mcrypt.hellug.gr/pub/mcrypt/libmcrypt/${P}.tar.gz"
HOMEPAGE="http://mcrypt.hellug.gr/"

DEPEND="virtual/glibc"

src_compile() {

	# Do not compile with -mcpu=k6/5 because of a k6/5 varible
	# in modules/algorithms/gosh.c
	CFLAGS="${CFLAGS/mcpu=k/march=k}"

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
