# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hardware-monitor/hardware-monitor-1.3.ebuild,v 1.7 2011/03/28 18:10:24 angelos Exp $

EAPI=3
inherit gnome2

DESCRIPTION="Gnome2 Hardware Monitor Applet"
HOMEPAGE="http://www.cs.auc.dk/~olau/hardware-monitor/"
SRC_URI="http://www.cs.auc.dk/~olau/hardware-monitor/source/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
# can add lmsensor stuff
IUSE=""

RDEPEND=">=dev-cpp/gconfmm-2.6.0
	dev-cpp/gtkmm:2.4
	dev-cpp/libgnomecanvasmm:2.6
	dev-cpp/libglademm:2.4
	>=gnome-base/gnome-panel-2
	gnome-base/libgtop:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"
