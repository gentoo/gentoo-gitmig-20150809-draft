# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gecko-mediaplayer/gecko-mediaplayer-0.9.7-r1.ebuild,v 1.2 2009/09/29 16:39:26 idl0r Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2 multilib

DESCRIPTION="A browser multimedia plugin using gnome-mplayer"
HOMEPAGE="http://code.google.com/p/gecko-mediaplayer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
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
	G2CONF="$(use_enable gnome schemas-install)
		$(use_with gnome gconf)
		--with-gio"
	DOCS="ChangeLog DOCS/tech/javascript.txt"
}

src_prepare() {
	# Fix as-needed, bug 279419 and bug 286795.
	# bug 279419 has been fixed by upstream in 0.9.8.
	sed -i -r \
		-e 's:(gecko_mediaplayer(_.+)?_so_LDFLAGS) = .*:\1 = -shared -fPIC:' \
		-e 's:(gecko_mediaplayer(_.+)?_so_LDADD = .*):\1 $(GLIB_LIBS) $(DBUS_LIBS) $(GCONF_LIBS):' \
		src/Makefile.in || die
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/${PN}

	# move plugins to correct location and clean up empty dirs
	dodir /usr/$(get_libdir)/nsbrowser/plugins
	mv "${D}"/usr/$(get_libdir)/nspr/mozilla/plugins/${PN}* \
		"${D}"/usr/$(get_libdir)/nsbrowser/plugins || die "mv plugins failed"
	rm -rf "${D}"/usr/$(get_libdir)/nspr
	rm -rf "${D}"/var
}
