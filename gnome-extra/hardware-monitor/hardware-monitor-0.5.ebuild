# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hardware-monitor/hardware-monitor-0.5.ebuild,v 1.2 2003/06/21 00:09:21 liquidx Exp $

inherit gnome2

DESCRIPTION="Gnome2 Hardware Monitor Applet using gnomemm"
HOMEPAGE="http://www.cs.auc.dk/~olau/hardware-monitor/"
SRC_URI="http://www.cs.auc.dk/~olau/hardware-monitor/source/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
# can add lmsensor stuff
IUSE=""

DEPEND=">=x11-libs/gtkmm-2.0
	>=dev-cpp/libgnomemm-1.3.9
	>=dev-cpp/libgnomeuimm-1.3.11
	>=dev-cpp/libglademm-2.0.0
	>=dev-cpp/libgnomecanvasmm-2.0.0
	>=dev-cpp/gconfmm-2.0.1
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/libgtop-2.0"
