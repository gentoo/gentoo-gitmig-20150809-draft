# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mtx/mtx-1.2.17.ebuild,v 1.4 2003/02/13 16:07:22 vapier Exp $

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
	dodoc CHANGES COMPATIBILITY FAQ README LICENSE TODO
	dohtml mtxl.README.html
	einstall || die "Install failed"
}
