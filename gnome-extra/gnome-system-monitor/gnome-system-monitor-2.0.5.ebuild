# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.0.5.ebuild,v 1.1 2003/06/20 14:54:57 liquidx Exp $

inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="Gnome System Monitor"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnome-2.2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgtop-2
	>=x11-libs/libwnck-0.12"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.22
	${RDEPEND}"
	 
DOCS="AUTHORS ChangeLog COPYING HACKING README INSTALL NEWS TODO"

src_unpack() {
	unpack ${A}
}

# fix some possible problem patchrelated
#MAKEOPTS="-j1"
