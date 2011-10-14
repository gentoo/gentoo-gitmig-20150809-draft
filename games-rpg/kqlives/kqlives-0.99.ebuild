# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/kqlives/kqlives-0.99.ebuild,v 1.5 2011/10/14 06:16:04 vapier Exp $

EAPI=2
inherit eutils games

MY_P=${P/lives}

DESCRIPTION="A console-style role playing game"
HOMEPAGE="http://kqlives.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cheats nls"

RDEPEND=">=x11-libs/gtk+-2.8:2
	>=gnome-base/libglade-2.4
	media-libs/allegro:0
	media-libs/aldumb
	dev-lang/lua
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable cheats)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	local x
	for x in diff draw draw2 dump; do
		mv -vf "${D}${GAMES_BINDIR}"/map${x} "${D}${GAMES_BINDIR}"/kq-map${x}
	done

	doicon "${FILESDIR}"/${PN}.xpm
	make_desktop_entry kq KqLives ${PN}

	prepgamesdirs
}
