# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gecko-mediaplayer/gecko-mediaplayer-0.9.8_p347.ebuild,v 1.3 2010/01/22 14:25:11 yngwin Exp $

EAPI=2
GCONF_DEBUG=no
inherit autotools eutils flag-o-matic gnome2 multilib

MY_P=${PN}-r${PV##*p}

DESCRIPTION="A browser multimedia plugin using gnome-mplayer"
HOMEPAGE="http://code.google.com/p/gecko-mediaplayer"
SRC_URI="http://dl.liveforge.org/distfiles/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="gnome"

RDEPEND=">=dev-libs/glib-2.14:2
	net-libs/xulrunner:1.9
	dev-libs/nspr
	>=dev-libs/dbus-glib-0.70
	>=media-video/gnome-mplayer-0.9.8
	gnome? ( >=gnome-base/gconf-2:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF="--disable-dependency-tracking
		$(use_enable gnome schemas-install)
		$(use_with gnome gconf)
		--with-gio"
	DOCS="ChangeLog DOCS/tech/javascript.txt"
}

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${P}-xulrunner-detection.patch
	eautoreconf
}

src_configure() {
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
