# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rman/rman-3.1.ebuild,v 1.3 2004/03/12 08:49:17 mr_bones_ Exp $

DESCRIPTION="PolyGlotMan man page translator AKA RosettaMan"
SRC_URI="mirror://sourceforge/polyglotman/${P}.tar.gz"
HOMEPAGE="http://polyglotman.sourceforge.net/"
KEYWORDS="x86 ppc sparc"
SLOT="0"
LICENSE="Artistic"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${PF}-gentoo.diff || die "patch failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -finline-functions" || die "make failed"
}

src_install () {
	dobin ${PN}
	doman ${PN}.1
}
