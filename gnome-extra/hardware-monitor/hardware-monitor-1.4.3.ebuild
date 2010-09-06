# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hardware-monitor/hardware-monitor-1.4.3.ebuild,v 1.2 2010/09/06 19:17:43 xmw Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools gnome2 eutils

DESCRIPTION="Gnome2 Hardware Monitor Applet"
HOMEPAGE="http://www.fnxweb.com/hardware-monitor-applet"
SRC_URI="http://www.fnxweb.com/software/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="lm_sensors"

RDEPEND=">=dev-cpp/gconfmm-2.28.2
	>=dev-cpp/gtkmm-2.20.3
	>=dev-cpp/libgnomecanvasmm-2.26.0
	>=dev-cpp/libglademm-2.2.7
	>=gnome-base/gnome-panel-2.30.2
	>=gnome-base/libgnomeui-2.24.3
	>=gnome-base/libgtop-2.28.1
	lm_sensors? ( >=sys-apps/lm_sensors-3 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.41.1"

DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with lm_sensors libsensors)"
}

src_prepare() {
	gnome2_src_prepare

	# Set and create "/viewer-type" key which does not exist yet
	# when the applet is loaded, in order to avoid a segfault,
	# bug 288552.
	epatch "${FILESDIR}/${P}-create-viewer-type-key.patch"

	# Fix intltool test failure
	echo "HardwareMonitor.server.in" >> po/POTFILES.in
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
