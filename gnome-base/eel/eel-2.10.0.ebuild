# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.10.0.ebuild,v 1.6 2005/03/20 02:55:30 kingtaco Exp $

inherit gnome2

DESCRIPTION="The Eazel Extentions Library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

RDEPEND=">=media-libs/libart_lgpl-2.3.8
	>=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2.3
	>=dev-libs/glib-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.7.92
	>=gnome-base/gnome-vfs-2.9
	>=dev-libs/popt-1.5
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gail-1
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2.1.4
	>=gnome-base/gnome-menus-2.9.1
	>=dev-util/desktop-file-utils-0.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog HACKING THANKS README NEWS TODO MAINTAINERS"
USE_DESTDIR="1"
