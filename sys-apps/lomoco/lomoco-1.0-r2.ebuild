# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lomoco/lomoco-1.0-r2.ebuild,v 1.2 2009/05/16 09:21:59 robbat2 Exp $

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
	cd "${S}"
	epatch ${FILESDIR}/${P}-gentoo-hardware-support.patch
	epatch ${FILESDIR}/${P}-updated-udev.patch
	eautoreconf
}

src_compile() {
	econf
	emake || die "make failed"
	awk -f udev/toudev.awk < src/lomoco.c > udev/40-lomoco.rules \
		|| die "failed to create udev rules"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /etc/udev/rules.d
	doins udev/40-lomoco.rules

	insinto /etc
	doins "${FILESDIR}"/lomoco.conf

	insinto /lib/udev
	insopts -m 0755
	newins udev/udev.lomoco lomoco

	dodoc AUTHORS ChangeLog NEWS README
}
