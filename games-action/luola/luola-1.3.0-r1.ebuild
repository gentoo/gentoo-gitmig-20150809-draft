# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/luola/luola-1.3.0-r1.ebuild,v 1.1 2006/04/08 16:41:05 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A 2D multiplayer arcade game resembling V-Wing"
HOMEPAGE="http://luolamies.org/software/luola/"
PATCHES="http://luolamies.org/software/luola/luola-1.3.0-1.patch
	http://luolamies.org/software/luola/luola-1.3.0-2.patch"
SRC_URI="http://luolamies.org/software/luola/${P}.tar.gz
	http://www.luolamies.org/software/luola/stdlevels-5.2.tar.gz
	http://www.luolamies.org/software/luola/nostalgia-1.1.tar.gz
	${PATCHES}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"

src_unpack() {
	local p

	unpack ${A}
	cd "${S}/src"
	for p in ${PATCHES}
	do
		epatch "${DISTDIR}/${p##*/}"
	done
}

src_compile() {
	egamesconf --enable-sound || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto "${GAMES_DATADIR}"/${PN}/levels
	doins "${WORKDIR}"/*.{lev,png} || die "doins failed"
	dodoc AUTHORS ChangeLog DATAFILE FAQ LEVELFILE README TODO \
		RELEASENOTES.txt ../README.Nostalgia
	newdoc ../README README.stdlevels
	doicon luola.png
	make_desktop_entry luola Luola
	prepgamesdirs
}
