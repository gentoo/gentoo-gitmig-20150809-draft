# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usbview/usbview-1.1.ebuild,v 1.6 2009/05/07 18:32:58 klausman Exp $

EAPI=2
inherit eutils

DESCRIPTION="Display the topology of devices on the USB bus"
HOMEPAGE="http://www.kroah.com/linux-usb/"
SRC_URI="http://www.kroah.com/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	doman ${PN}.8
	doicon usb_icon.xpm
	make_desktop_entry ${PN} "USB Viewer" usb_icon
}
