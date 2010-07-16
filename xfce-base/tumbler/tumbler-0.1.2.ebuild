# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/tumbler/tumbler-0.1.2.ebuild,v 1.1 2010/07/16 22:30:45 darkside Exp $

EAPI=2
inherit xfconf

DESCRIPTION="A D-Bus service for applications to request thumbnails"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.16
	>=dev-libs/dbus-glib-0.72
	>=sys-apps/dbus-1
	>=media-libs/libpng-1.2
	>=x11-libs/gtk+-2.14:2
	media-libs/freetype:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	XFCONF="--disable-dependency-tracking
		--disable-static
		$(xfconf_use_debug)
		--with-html-dir=/usr/share/doc/${PF}/html"
}
