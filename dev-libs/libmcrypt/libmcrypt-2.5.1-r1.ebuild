# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.1-r1.ebuild,v 1.2 2002/06/24 12:28:04 stroke Exp $

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
        # econf --host=${CHOST} \ 
	export WANT_AUTOMAKE_1_6=1
	autoreconf --force --install --symlink || die
	econf --disable-posix-threads || die
		
	# PHP manual states to disable posix threads, no further explanation given, but i'll
	# stick with it :) (Source: http://www.php.net/manual/en/ref.mcrypt.php)

	emake || die
}

src_install () {
	
	dodir /usr/{bin,include,lib}
	
	einstall || die

	dodoc AUTHORS COPYING INSTALL KNOW-BUGS NEWS README THANKS TODO doc/README.* doc/example.c
}
