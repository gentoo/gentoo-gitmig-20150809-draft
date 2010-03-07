# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lomoco/lomoco-1.0-r3.ebuild,v 1.1 2010/03/07 12:39:27 hollow Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Lomoco can configure vendor-specific options on Logitech USB mice."
HOMEPAGE="http://lomoco.linux-gamers.net/"
SRC_URI="http://lomoco.linux-gamers.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND="=virtual/libusb-0*"
RDEPEND="${DEPEND} !<sys-fs/udev-114"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo-hardware-support.patch
	epatch "${FILESDIR}"/${P}-updated-udev.patch
	eautoreconf
}

src_compile() {
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
