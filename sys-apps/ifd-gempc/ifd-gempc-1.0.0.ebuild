# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifd-gempc/ifd-gempc-1.0.0.ebuild,v 1.2 2007/07/12 05:10:21 mr_bones_ Exp $

inherit eutils

DESCRIPTION="GemCore based PC/SC reader drivers for pcsc-lite"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC"
LICENSE="GPL-2 BSD"
KEYWORDS="~ppc ~x86"
SLOT="0"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC/${P}.tar.gz"
IUSE=""
RDEPEND=">=sys-apps/pcsc-lite-1.2.9_beta5
	>=dev-libs/libusb-0.1.10a"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-pcsc-lite-include.patch
}

src_compile() {
	emake || die
}

src_install () {
	emake DESTDIR=${D} install || die
	dodoc README*
}
