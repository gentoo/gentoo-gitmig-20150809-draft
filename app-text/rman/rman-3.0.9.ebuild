# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rman/rman-3.0.9.ebuild,v 1.11 2004/02/22 20:06:16 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PolyGlotMan man page translator AKA RosettaMan"
SRC_URI="http://polyglotman.sourceforge.net/${PN}.tar.gz"
HOMEPAGE="http://polyglotman.sourceforge.net/"
KEYWORDS="x86 ppc sparc"
SLOT="0"
LICENSE="Artistic"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake CFLAGS="${CFLAGS} -finline-functions" || die
}

src_install () {
	dobin ${PN}
	doman ${PN}.1
}
