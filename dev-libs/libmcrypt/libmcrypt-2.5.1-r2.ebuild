# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.1-r2.ebuild,v 1.1 2002/06/24 14:09:40 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
SRC_URI="ftp://mcrypt.hellug.gr/pub/mcrypt/libmcrypt/${P}.tar.gz"
HOMEPAGE="http://mcrypt.hellug.gr/"

DEPEND="virtual/glibc
	>=sys-devel/automake-1.6.1"
RDEPEND="virtual/glibc"
SLOT="0"
LICENSE="GPL-2"

src_compile() {

	# Do not compile with -mcpu=k6/5 because of a k6/5 varible
	# in modules/algorithms/gosh.c
	CFLAGS="${CFLAGS/mcpu=k/march=k}"

	# Doesn't work with --host bug #3517
	elibtoolize
	econf --disable-posix-threads || die
		
	# PHP manual states to disable posix threads, no further explanation 
	# given, but i'll stick with it :)
	# (Source: http://www.php.net/manual/en/ref.mcrypt.php)

	emake || die
}

src_install () {
	
	dodir /usr/{bin,include,lib}
	
	einstall || die

	dodoc AUTHORS COPYING INSTALL KNOW-BUGS NEWS README THANKS TODO
	dodoc doc/README.* doc/example.c
}
