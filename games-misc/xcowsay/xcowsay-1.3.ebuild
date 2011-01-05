# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xcowsay/xcowsay-1.3.ebuild,v 1.1 2011/01/05 22:12:20 hwoarang Exp $

EAPI="2"

DESCRIPTION="configurable talking graphical cow (inspired by cowsay)"
HOMEPAGE="http://www.doof.me.uk/xcowsay/"
SRC_URI="http://www.nickg.me.uk/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus fortune"

RDEPEND="dbus? ( sys-apps/dbus )
	dev-libs/dbus-glib
	fortune? ( games-misc/fortune-mod )
	media-libs/freetype:2
	media-libs/libpng
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable dbus)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	if ! use fortune; then
		rm -f "${D}"/usr/bin/xcowfortune
	fi
}
