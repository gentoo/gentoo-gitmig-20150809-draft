# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.2.4.ebuild,v 1.1 2003/05/08 14:21:36 foser Exp $

inherit gnome2

IUSE=""
DESCRIPTION="EEL is the Eazel Extentions Library"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 LGPL-2" 
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2.1
	>=media-libs/libart_lgpl-2.3.8
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gnome-vfs-2
	>=dev-libs/popt-1.5
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gail-0.16"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"		

DOCS="AUTHORS ChangeLog COPYING* HACKING THANKS README INSTALL NEWS TODO MAINTAINERS"
