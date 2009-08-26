# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/indicator-messages/indicator-messages-0.1.6.ebuild,v 1.1 2009/08/26 06:29:29 ssuominen Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="A small applet to display information from various applications consistently in the panel"
HOMEPAGE="https://launchpad.net/indicator-applet/"
SRC_URI="http://launchpad.net/indicator-applet/0.1/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	>=gnome-extra/indicator-applet-0.1.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	G2CONF="--disable-dependency-tracking"
	DOCS="AUTHORS"
}
