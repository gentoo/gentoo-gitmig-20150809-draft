# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.2.2.ebuild,v 1.3 2003/05/30 11:17:43 lu_zero Exp $

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Utilities for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~alpha ~sparc"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-1.2.1"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --disable-guname-capplet --enable-gcolorsel-applet --enable-gdialog"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS"
