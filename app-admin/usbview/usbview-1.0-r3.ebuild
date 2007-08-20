# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usbview/usbview-1.0-r3.ebuild,v 1.8 2007/08/20 09:21:59 jokey Exp $

inherit eutils

DESCRIPTION="Display the topology of devices on the USB bus"
HOMEPAGE="http://www.kroah.com/linux-usb/"
SRC_URI="http://www.kroah.com/linux-usb/${P}.tar.gz
	mirror://debian/pool/main/u/${PN}/${PN}_${PV}-11.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PN}_${PV}-11.diff
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
	doman usbview.8
	doicon ${PN}_logo.xpm
	make_desktop_entry ${PN} "USB Viewer" ${PN}_logo.xpm
}
