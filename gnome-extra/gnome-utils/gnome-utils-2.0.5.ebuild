# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.0.5.ebuild,v 1.7 2003/06/10 13:03:12 liquidx Exp $

inherit gnome2


S=${WORKDIR}/${P}
DESCRIPTION="Utilities for the Gnome2 desktop"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc  ppc alpha"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/pango-1.0.4
	>=dev-libs/atk-1.0.3
	>=x11-libs/gtk+-2.0.6
	>=app-text/scrollkeeper-0.3.11
	>=media-libs/freetype-2.0.9
	>=x11-libs/libzvt-2.0.1
	>=gnome-base/libglade-2.0.1
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/gnome-panel-2.0.8
	>=gnome-base/gnome-vfs-2.0.4
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/libgnomecanvas-2.0.4
	>=gnome-base/bonobo-activation-1.0.3
	=gnome-extra/libgtkhtml-2*
	>=dev-libs/libxml2-2.4.24
	>=sys-libs/ncurses-5.2-r5
	>=gnome-base/libgtop-2.0.0
	>=net-libs/linc-0.5.3"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --disable-guname-capplet --enable-gcolorsel-applet --with-ncurses --enable-gdialog"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README* THANKS"

		
