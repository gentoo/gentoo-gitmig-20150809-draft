# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

IUSE=""

DESCRIPTION="Utilities for controlling SCSI media changers and tape drives"
HOMEPAGE="http://mtx.sourceforge.net"
LICENSE="GPL"
DEPEND="virtual/glibc"
SRC_URI="mirror://sourceforge/${PN}/${P}rel.tar.gz"
S=${WORKDIR}/${P}
KEYWORDS="~x86"
SLOT="0"

src_unpack() {
	unpack ${A}
	mv ${P}rel ${S}
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install () {
	dodoc CHANGES COMPATIBILITY FAQ README LICENSE TODO mtxl.README.html
	einstall || die "Install failed"
}
