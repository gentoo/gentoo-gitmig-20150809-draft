# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.0.4-r1.ebuild,v 1.10 2003/07/04 22:22:54 gmsoft Exp $

inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="Procman - The Gnome System Monitor"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha ~sparc hppa"

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

	# add some eyecandy to the devices view
#	cd ${S}; epatch ${FILESDIR}/${PN}-devicesviewimprovements.patch
	# disabled since it causes weird make order related problems
	# on different systems
}

# fix some possible problem patchrelated
#MAKEOPTS="-j1"
