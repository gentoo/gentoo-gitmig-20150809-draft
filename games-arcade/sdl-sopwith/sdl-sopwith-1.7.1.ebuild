# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdl-sopwith/sdl-sopwith-1.7.1.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

MY_P="${P/-/_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Port of the classic Sopwith game using LibSDL"
HOMEPAGE="http://sdl-sopwith.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.3
	dev-libs/atk
	x11-libs/pango
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	dev-util/pkgconfig
	media-libs/gdk-pixbuf
	>=media-libs/freetype-2"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO doc/*txt || die "dodoc failed"
	rm -rf "${D}/usr/games/share/"
	prepgamesdirs
}
