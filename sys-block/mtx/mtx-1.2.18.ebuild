# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mtx/mtx-1.2.18.ebuild,v 1.1 2005/03/15 19:48:09 ciaranm Exp $

IUSE=""

DESCRIPTION="Utilities for controlling SCSI media changers and tape drives"
HOMEPAGE="http://mtx.sourceforge.net"
LICENSE="GPL-2"
DEPEND="virtual/libc"
SRC_URI="ftp://ftp.badtux.net/pub/storage/${PN}/${P}rel.tar.gz"
KEYWORDS="x86 amd64 sparc alpha ppc hppa"
SLOT="0"

src_unpack() {
	unpack ${A}
	mv ${P}rel ${S}
	sed -e 's:/usr/src/linux/include ::' -i ${S}/Makefile.in
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
