# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hsc/hsc-0.935.ebuild,v 1.5 2009/09/23 19:37:23 patrick Exp $

DESCRIPTION="An HTML preprocessor using ML syntax"
HOMEPAGE="http://www.linguistik.uni-erlangen.de/~msbethke/software.html"
SRC_URI="http://www.linguistik.uni-erlangen.de/~msbethke/binaries/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

IUSE=""

DEPEND=""

src_compile() {
	make || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share
	#This makefile uses INSTDIR instead of DESTDIR
	make INSTDIR=${D}/usr/ install || die
}

pkg_postinst() {
	einfo Documentation and examples for HSC are available in
	einfo /usr/share/doc/${P}/
}
