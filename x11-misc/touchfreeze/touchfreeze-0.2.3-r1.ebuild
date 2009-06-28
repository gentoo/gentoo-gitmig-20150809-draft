# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/touchfreeze/touchfreeze-0.2.3-r1.ebuild,v 1.1 2009/06/28 18:56:32 hwoarang Exp $

EAPI="2"

inherit qt4

DESCRIPTION="X11 touch pad driver configuration utility"
HOMEPAGE="http://qsynaptics.sourceforge.net/"
SRC_URI="http://qsynaptics.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-drivers/xf86-input-synaptics"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 TouchFreeze.pro
}

src_install() {
	dobin ${PN} || die "dobin failed"
	newicon res/touchpad.svg ${PN}.svg || die "new icon failed"
	dodoc AUTHORS README || die "dodoc failed"
	make_desktop_entry ${PN} TouchFreeze ${PN} 'Qt;System' || die "make_desktop_entry failed"
}
