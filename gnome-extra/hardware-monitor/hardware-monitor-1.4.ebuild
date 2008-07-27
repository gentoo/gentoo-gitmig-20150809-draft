# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hardware-monitor/hardware-monitor-1.4.ebuild,v 1.1 2008/07/27 09:12:20 ford_prefect Exp $

inherit gnome2

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
		>=gnome-base/libgtop-2.6.0
		lm_sensors? ( sys-apps/lm_sensors )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		>=dev-util/intltool-0.29"

pkg_setup() {
	G2CONF="${G2CONF} \
			$(use_with lm_sensors libsensors)"
}
