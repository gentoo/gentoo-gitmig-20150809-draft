# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.5.91.1.ebuild,v 1.1 2004/03/20 22:57:03 foser Exp $

inherit gnome2

IUSE=""
DESCRIPTION="The Eazel Extentions Library"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.3
	>=gnome-base/gconf-1.2
	>=media-libs/libart_lgpl-2.3.8
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gnome-vfs-2
	>=dev-libs/popt-1.5
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gail-1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING* HACKING THANKS README INSTALL NEWS TODO MAINTAINERS"
