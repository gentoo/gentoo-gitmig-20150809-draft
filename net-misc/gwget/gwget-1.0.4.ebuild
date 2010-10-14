# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwget/gwget-1.0.4.ebuild,v 1.4 2010/10/14 17:02:29 ranger Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GTK2 WGet Frontend"
HOMEPAGE="http://gnome.org/projects/gwget/"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="epiphany libnotify"

# FIXME: dbus should be optional
#        needs patching for linguas/intltool
RDEPEND="net-misc/wget
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.16.0
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=dev-libs/dbus-glib-0.70
	epiphany? ( >=www-client/epiphany-1.4 )
	libnotify? ( >=x11-libs/libnotify-0.2.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0
	>=sys-devel/gettext-0.10.4"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable epiphany epiphany-extension)
		$(use_enable libnotify)
		--disable-static
		--disable-schemas-install"
}

src_install() {
	gnome2_src_install

	# remove /var/lib, which is created without any reason
	rm -rf "${D}"/var || die "rm failed"

	# remove useless la files
	find "${D}" -name '*.la' -delete
}
