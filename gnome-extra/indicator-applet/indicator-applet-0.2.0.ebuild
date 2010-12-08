# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/indicator-applet/indicator-applet-0.2.0.ebuild,v 1.4 2010/12/08 17:28:03 pacho Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A small applet to display information from various applications consistently in the panel"
HOMEPAGE="http://launchpad.net/indicator-applet/"
SRC_URI="http://launchpad.net/${PN}/0.2/0.2/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/dbus-glib-0.76
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-2
	>=dev-libs/libindicator-0.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

pkg_setup() {
	G2CONF="$(use_enable nls)
		--disable-dependency-tracking"
	DOCS="AUTHORS"
}

src_prepare() {
	gnome2_src_prepare

	# Remove useless applet, bug #286143
	sed 's/src-session//' -i Makefile.am Makefile.in || die "sed failed"
	sed 's/GNOME_FastUserSwitchApplet.server.in//' \
		-i data/Makefile.am data/Makefile.in || die "sed 2 failed"
}
