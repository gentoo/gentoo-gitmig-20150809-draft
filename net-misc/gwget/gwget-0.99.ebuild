# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwget/gwget-0.99.ebuild,v 1.2 2007/07/07 22:43:15 mr_bones_ Exp $

inherit gnome2

DESCRIPTION="GTK2 WGet Frontend"
HOMEPAGE="http://gnome.org/projects/gwget/"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="epiphany"

RDEPEND="net-misc/wget
		 >=x11-libs/gtk+-2.6
		 >=dev-libs/glib-2.4.0
		 >=gnome-base/gconf-2
		 >=gnome-base/libglade-2
		 >=gnome-base/libbonobo-2
		 >=gnome-base/libgnomeui-2
		 epiphany? ( >=www-client/epiphany-1.4 )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		>=dev-util/intltool-0.29
		>=sys-devel/gettext-0.10.4"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
USE_DESTDIR="1"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable epiphany epiphany-extension)"
}

src_install() {
	gnome2_src_install

	# remove /var/lib, which is created without any reason
	rm -rf ${D}/var
}
