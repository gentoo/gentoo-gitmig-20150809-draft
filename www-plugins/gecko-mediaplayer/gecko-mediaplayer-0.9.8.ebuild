# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gecko-mediaplayer/gecko-mediaplayer-0.9.8.ebuild,v 1.7 2009/12/08 01:47:48 jer Exp $

EAPI=2
GCONF_DEBUG=no
inherit autotools eutils flag-o-matic gnome2 multilib

DESCRIPTION="A browser multimedia plugin using gnome-mplayer"
HOMEPAGE="http://code.google.com/p/gecko-mediaplayer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~ppc64 x86"
IUSE="gnome"

RDEPEND=">=dev-libs/glib-2.14:2
	net-libs/xulrunner:1.9
	dev-libs/nspr
	>=dev-libs/dbus-glib-0.70
	>=media-video/gnome-mplayer-${PV}
	gnome? ( >=gnome-base/gconf-2:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="--disable-dependency-tracking
		$(use_enable gnome schemas-install)
		--with-xulrunner-sdk
		$(use_with gnome gconf)
		--with-gio"
	DOCS="ChangeLog DOCS/tech/javascript.txt"
}

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${P}-asneeded.patch
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	append-flags "$(pkg-config --cflags-only-I libxul)"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/${PN}

	# move plugins to correct location and clean up empty dirs
	dodir /usr/$(get_libdir)/nsbrowser/plugins
	mv "${D}"/usr/$(get_libdir)/nspr/mozilla/plugins/${PN}* \
		"${D}"/usr/$(get_libdir)/nsbrowser/plugins || die "plugins move failed"
	rm -rf "${D}"/usr/$(get_libdir)/nspr
	rm -rf "${D}"/var
}
