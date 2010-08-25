# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xcowsay/xcowsay-1.2.ebuild,v 1.1 2010/08/25 10:27:06 hwoarang Exp $

EAPI="2"

inherit base

DESCRIPTION="configurable talking graphical cow (inspired by cowsay)"
HOMEPAGE="http://www.doof.me.uk/xcowsay/"
SRC_URI="http://www.nickg.me.uk/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

RDEPEND="dbus? ( sys-apps/dbus )
	games-misc/fortune-mod
	media-libs/freetype:2
	media-libs/libpng
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable dbus)
}
