# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hsc/hsc-0.999.ebuild,v 1.2 2007/07/12 02:52:15 mr_bones_ Exp $

DESCRIPTION="An HTML preprocessor using ML syntax"
HOMEPAGE="http://www.linguistik.uni-erlangen.de/~msbethke/software.html"
SRC_URI="http://www.linguistik.uni-erlangen.de/~msbethke/binaries/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf
	emake -j1 || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/doc/hsc
	dodir /usr/share/hsc

	make BINDIR=${D}/usr/bin DATADIR=${D}/usr/share/hsc \
		prefix=${D}/usr docdir=${D}/usr/share/doc/hsc datadir=${D}/usr/share/hsc install || die
}

pkg_postinst() {
	einfo Documentation and examples for HSC are available in
	einfo /usr/share/doc/${P}/
}
