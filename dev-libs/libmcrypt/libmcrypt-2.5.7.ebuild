# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.7.ebuild,v 1.1 2003/04/24 17:26:51 robbat2 Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
SRC_URI="ftp://mcrypt.hellug.gr/pub/mcrypt/libmcrypt/${P}.tar.gz"
HOMEPAGE="http://mcrypt.hellug.gr/"

DEPEND=">=sys-devel/automake-1.6.1
	>=sys-devel/libtool-1.4.1-r8"
IUSE=""
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc ~hppa ~alpha"

src_compile() {

	local myconf
	myconf=""
	use pic && myconf="${myconf} --with-pic"
	econf ${myconf} || die "configure failure"

	emake || die "make failure"
}

src_install () {

	dodir /usr/{bin,include,lib}

	einstall || die "install failure"

	dodoc AUTHORS KNOWN-BUGS COPYING COPYING.LIB INSTALL NEWS README THANKS TODO ChangeLog
	dodoc doc/README.* doc/example.c
	prepalldocs
}
