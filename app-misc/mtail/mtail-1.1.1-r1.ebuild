# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mtail/mtail-1.1.1-r1.ebuild,v 1.5 2004/02/16 21:46:32 ciaranm Exp $

DESCRIPTION="tail workalike, that performs output colourising"
HOMEPAGE="http://matt.immute.net/src/mtail/"
SRC_URI="http://matt.immute.net/src/mtail/mtail-${PV}.tgz
	http://matt.immute.net/src/mtail/mtailrc-syslog.sample"
LICENSE="as-is"

SLOT="0"
KEYWORDS="x86 alpha sparc amd64 ~mips"
IUSE=""

DEPEND=""

RDEPEND="dev-lang/python"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${P}.tgz
	cd ${S}; epatch ${FILESDIR}/${P}-remove-blanks.patch
}

src_install() {
	dobin mtail
	dodoc CHANGES LICENSE mtailrc.sample README ${DISTDIR}/mtailrc-syslog.sample
}
