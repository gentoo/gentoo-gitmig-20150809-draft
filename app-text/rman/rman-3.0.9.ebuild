# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rman/rman-3.0.9.ebuild,v 1.7 2002/11/23 20:23:19 cybersystem Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PolyGlotMan man page translator AKA RosettaMan"
SRC_URI="http://polyglotman.sourceforge.net/${PN}.tar.gz"
HOMEPAGE="http://polyglotman.sourceforge.net/"
KEYWORDS="x86 ~ppc sparc sparc64"
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
