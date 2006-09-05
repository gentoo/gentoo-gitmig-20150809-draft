# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.10.1.ebuild,v 1.22 2006/09/05 01:47:08 kumba Exp $

inherit virtualx gnome2

DESCRIPTION="The Eazel Extentions Library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/libart_lgpl-2.3.8
	>=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2.6
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

src_test() {
	if hasq userpriv ${FEATURES} ;
	then
		Xmake check || die
	else
		einfo "Not running tests without userpriv"
	fi
}
