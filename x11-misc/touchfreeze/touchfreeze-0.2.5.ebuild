# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/touchfreeze/touchfreeze-0.2.5.ebuild,v 1.3 2010/10/10 09:26:00 phajdan.jr Exp $

EAPI="2"

inherit qt4-r2

DESCRIPTION="X11 touch pad driver configuration utility"
HOMEPAGE="http://kde-apps.org/content/show.php/TouchFreeze?content=61442"
SRC_URI="http://www.fit.vutbr.cz/~kombrink/personal/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-drivers/xf86-input-synaptics"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN} || die "dobin failed"
	newicon res/touchpad.svg ${PN}.svg || die "new icon failed"
	dodoc AUTHORS README || die "dodoc failed"
	make_desktop_entry ${PN} TouchFreeze ${PN} 'Qt;System'
}
