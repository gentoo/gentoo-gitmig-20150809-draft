# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hardware-monitor/hardware-monitor-1.4.2-r1.ebuild,v 1.2 2009/11/04 22:26:03 eva Exp $

GCONF_DEBUG="no"

inherit gnome2 eutils

DESCRIPTION="Gnome2 Hardware Monitor Applet"
HOMEPAGE="http://people.iola.dk/olau/hardware-monitor/"
SRC_URI="http://people.iola.dk/olau/hardware-monitor/source/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="lm_sensors"

RDEPEND=">=dev-cpp/gconfmm-2.6.0
	>=dev-cpp/gtkmm-2.6.0
	>=dev-cpp/libgnomecanvasmm-2.6.0
	>=dev-cpp/libglademm-2.6.0
	>=gnome-base/gnome-panel-2
	>=gnome-base/libgnomeui-2.20.1
	>=gnome-base/libgtop-2.6.0
	lm_sensors? ( >=sys-apps/lm_sensors-3 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with lm_sensors libsensors)"
}

src_unpack() {
	gnome2_src_unpack

	# Set and create "/viewer-type" key which does not exist yet
	# when the applet is loaded, in order to avoid a segfault,
	# bug 288552.
	epatch "${FILESDIR}/${P}-create-viewer-type-key.patch"

	# Fix intltool test failure
	echo "HardwareMonitor.server.in" >> po/POTFILES.in
}
