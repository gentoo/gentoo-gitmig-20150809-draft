# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.8.0.ebuild,v 1.7 2004/12/11 10:26:05 kloeri Exp $

inherit gnome2

DESCRIPTION="The Eazel Extentions Library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 ppc alpha sparc ~hppa ~amd64 ~ia64 ~mips ~ppc64 ~arm"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.3
	>=gnome-base/gconf-1.2
	>=media-libs/libart_lgpl-2.3.8
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gnome-vfs-2.7.91
	>=dev-libs/popt-1.5
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.7.92
	>=gnome-base/gail-1
	>=dev-util/desktop-file-utils-0.7"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING* HACKING THANKS README INSTALL NEWS TODO MAINTAINERS"
