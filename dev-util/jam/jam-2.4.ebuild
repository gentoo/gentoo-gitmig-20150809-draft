# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jam/jam-2.4.ebuild,v 1.1 2002/11/04 01:22:28 jrray Exp $

DESCRIPTION="jam (Just Another Make) - advanced make replacement"
HOMEPAGE="http://www.perforce.com/jam/jam.html"
SRC_URI="ftp://ftp.perforce.com/pub/jam/${P}.zip"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-util/yacc"
RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
    # the bootstrap makefile assumes ${S} is in the path
	PATH=${PATH}:${S} make || die
}

src_install() {
	cd ${S}
	BINDIR=${D}/usr/bin ./jam0 install
	dohtml Jam.html Jambase.html Jamfile.html
	dodoc README RELNOTES Porting
}
