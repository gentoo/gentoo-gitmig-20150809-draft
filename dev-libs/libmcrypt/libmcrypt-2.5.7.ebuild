# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.7.ebuild,v 1.8 2004/01/24 08:23:59 robbat2 Exp $

inherit libtool

DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
HOMEPAGE="http://mcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mcrypt/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ~ppc hppa alpha amd64 ia64"

DEPEND=">=sys-devel/automake-1.6.1
	>=sys-devel/libtool-1.4.1-r8"

src_compile() {
	econf || die "configure failure"
	emake || die "make failure"
}

src_install() {
	dodir /usr/{bin,include,lib}
	einstall || die "install failure"

	dodoc AUTHORS KNOWN-BUGS COPYING COPYING.LIB INSTALL NEWS README THANKS TODO ChangeLog
	dodoc doc/README.* doc/example.c
	prepalldocs
}
