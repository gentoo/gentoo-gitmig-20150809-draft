# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/indicator-applet/indicator-applet-0.4.12.ebuild,v 1.1 2011/11/19 18:33:59 ssuominen Exp $

EAPI=4
GCONF_DEBUG=no
inherit autotools gnome2

DESCRIPTION="A small applet to display information from various applications consistently in the panel"
HOMEPAGE="http://launchpad.net/indicator-applet/"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.18:2
	>=gnome-base/gnome-panel-2.32[bonobo]
	>=dev-libs/libindicator-0.4
	x11-libs/libX11
	>=x11-libs/gtk+-2.12:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog"

src_prepare() {
	sed -i \
		-e 's:indicator >=:indicator-0.4 >=:' \
		-e '/PKG_CONFIG/s:indicator:indicator-0.4:' \
		configure.ac || die

	eautoreconf

	gnome2_src_prepare
}
