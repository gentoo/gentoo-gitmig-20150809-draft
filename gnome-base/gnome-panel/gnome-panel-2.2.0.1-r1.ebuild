# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.2.0.1-r1.ebuild,v 1.3 2003/03/01 14:45:09 weeve Exp $

inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="The Panel for Gnome2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 FDL-1.1 LGPL-2"
KEYWORDS="x86 ~ppc alpha ~sparc"

IUSE="doc"
MAKEOPTS="-j1"

RDEPEND=">=x11-libs/gtk+-2.1
	>=x11-libs/libwnck-2.1.5
	>=gnome-base/ORBit2-2.4
	>=gnome-base/bonobo-activation-2
	>=gnome-base/gnome-vfs-2.1.3
	>=gnome-base/gnome-desktop-2.1.4
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.1.1
	>=gnome-base/libgnomeui-2.1
	!gnome-extra/system-tray-applet"

DEPEND="${RDEPEND}
	>=gnome-base/gconf-1.2.1
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	doc? ( >=dev-util/gtk-doc-0.9 )"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-notification_area_crash_on_exit_fix.patch
}

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README"
