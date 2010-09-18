# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/indicator-applet/indicator-applet-0.4.5.ebuild,v 1.1 2010/09/18 19:41:51 eva Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2 versionator

DESCRIPTION="A small applet to display information from various applications consistently in the panel"
HOMEPAGE="http://launchpad.net/indicator-applet/"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/dbus-glib-0.76
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-2
	>=dev-libs/libindicator-0.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=dev-util/intltool-0.35 )"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable nls)
		--disable-dependency-tracking"
	DOCS="AUTHORS"
}

src_prepare() {
	gnome2_src_prepare

	# Don't collide with gdm-user-switch-applet's bonobo file
	# Note: in this dev-cycle src-session/ was dropped (on upstream)
	# and is a part from src/ now, without copy paste
	mv data/GNOME_{FastUserSwitchApplet,IndicatorAppletSession}.server.in.in \
		|| die "Could not move file"
	epatch "${FILESDIR}/${PN}-0.4.5-fastuserswitchapplet-collision.patch"

	# Note: there are no translations in po/
	eautoreconf
}
