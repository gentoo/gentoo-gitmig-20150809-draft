# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gecko-mediaplayer/gecko-mediaplayer-1.0.3.ebuild,v 1.1 2011/04/22 11:26:12 ssuominen Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2 multilib nsplugins

DESCRIPTION="A browser plugin that uses GNOME MPlayer"
HOMEPAGE="http://code.google.com/p/gecko-mediaplayer/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="curl gnome"

RDEPEND=">=dev-libs/glib-2.14:2
	net-libs/xulrunner:1.9
	dev-libs/nspr
	>=dev-libs/dbus-glib-0.92
	>=media-video/gnome-mplayer-${PV}[dbus]
	curl? ( net-misc/curl )
	gnome? ( gnome-base/gconf:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="--disable-dependency-tracking
		$(use_enable gnome schemas-install)
		$(use_with gnome gconf)
		--with-gio
		$(use_with curl libcurl)
		--with-plugin-dir=/usr/$(get_libdir)/${PLUGINS_DIR}"

	DOCS="ChangeLog DOCS/tech/javascript.txt"
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
	rmdir -p "${D}"/var/lib
}
