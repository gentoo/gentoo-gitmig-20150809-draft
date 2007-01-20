# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/compiz-settings/compiz-settings-0.07.ebuild,v 1.2 2007/01/20 04:34:11 hanno Exp $

DESCRIPTION="Configuration tool for compiz window manager"
HOMEPAGE="http://forum.go-compiz.org/viewtopic.php?t=153"
SRC_URI="http://compiz.biz/compiz-settings/${PN}_${PV}-2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-wm/compiz-0.3.4
	>=sys-apps/dbus-1.0"

S=${WORKDIR}/${PN/-/}-trunk

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
}
