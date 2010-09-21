# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/indicator-messages/indicator-messages-0.3.11.ebuild,v 1.1 2010/09/21 20:47:26 eva Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2 versionator

DESCRIPTION="A small applet to display information from various applications consistently in the panel"
HOMEPAGE="https://launchpad.net/indicator-applet/"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/libindicate-0.3
	>=dev-libs/libindicator-0.3.5
	>=dev-libs/libdbusmenu-0.2.8[gtk]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

pkg_setup() {
	G2CONF="$(use_enable nls)
		--disable-dependency-tracking"
	DOCS="AUTHORS"
}
