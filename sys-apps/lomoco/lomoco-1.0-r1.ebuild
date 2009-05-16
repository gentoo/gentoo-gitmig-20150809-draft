# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lomoco/lomoco-1.0-r1.ebuild,v 1.3 2009/05/16 09:21:59 robbat2 Exp $

inherit autotools eutils

DESCRIPTION="Lomoco can configure vendor-specific options on Logitech USB mice \
(or dual-personality mice plugged into the USB port). Visit the website for \
specific available options."
HOMEPAGE="http://lomoco.linux-gamers.net/"
SRC_URI="http://lomoco.linux-gamers.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~x86"
IUSE=""

DEPEND="=virtual/libusb-0*"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo-hardware-support.patch
	cd ${S}
	eautoreconf
}

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
