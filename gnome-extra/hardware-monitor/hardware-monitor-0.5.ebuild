# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hardware-monitor/hardware-monitor-0.5.ebuild,v 1.1 2003/04/26 21:57:36 liquidx Exp $

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
	>=gnome-extra/libgnomemm-1.3.9
	>=gnome-extra/libgnomeuimm-1.3.11
	>=gnome-extra/libglademm-2.0.0
	>=gnome-extra/libgnomecanvasmm-2.0.0
	>=gnome-extra/gconfmm-2.0.1
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/libgtop-2.0"
