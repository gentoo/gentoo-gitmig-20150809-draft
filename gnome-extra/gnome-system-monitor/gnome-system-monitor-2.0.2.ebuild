# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.0.2.ebuild,v 1.1 2002/09/06 03:56:37 spider Exp $


inherit gnome2


S=${WORKDIR}/${P}
DESCRIPTION="Procman - The Gnome System Monitor"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"


RDEPEND=">=x11-libs/gtk+-2.0.6
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/libgnome-2.0.4
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libgtop-2.0.0
	>=x11-libs/libwnck-0.17
	>=gnome-base/libgnomecanvas-2.0.4
	>=app-text/scrollkeeper-0.3.11"

DEPEND=">=dev-util/pkgconfig-0.12.0
	 >=dev-util/intltool-0.22
	 ${RDEPEND}"
	 
DOCS="AUTHORS ChangeLog COPYING HACKING README* INSTALL NEWS TODO"



