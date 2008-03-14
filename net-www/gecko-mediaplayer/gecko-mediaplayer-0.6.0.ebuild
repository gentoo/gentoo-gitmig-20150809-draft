# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gecko-mediaplayer/gecko-mediaplayer-0.6.0.ebuild,v 1.2 2008/03/14 17:37:36 armin76 Exp $

inherit multilib

DESCRIPTION="A browser plug-in for GNOME MPlayer."
HOMEPAGE="http://dekorte.homeip.net/download/gecko-mediaplayer"
SRC_URI="http://dekorte.homeip.net/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/dbus-glib-0.7
	>=media-video/gnome-mplayer-0.6
	|| ( =net-libs/xulrunner-1.8*
		=www-client/mozilla-firefox-2*
		=www-client/seamonkey-1*
		www-client/epiphany )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodir /usr/$(get_libdir)/nsbrowser/plugins

	mv "${D}"/usr/$(get_libdir)/mozilla/plugins/${PN}* \
		"${D}"/usr/$(get_libdir)/nsbrowser/plugins

	rm -rf "${D}"/usr/share/doc/${PN}

	dodoc ChangeLog
}
