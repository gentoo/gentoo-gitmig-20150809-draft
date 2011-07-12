# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-2.1.1.ebuild,v 1.2 2011/07/12 17:42:51 mr_bones_ Exp $

EAPI=2
inherit autotools base eutils flag-o-matic games

DESCRIPTION="Bomberman-like multiplayer game"
HOMEPAGE="http://savannah.nongnu.org/projects/clanbomber/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,joystick,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-gfx
	>dev-libs/boost-1.36
	<dev-libs/boost-1.46
	media-fonts/dejavu"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog ChangeLog.hg IDEAS NEWS QUOTES README TODO )

src_prepare() {
	local boost_ver=$(best_version "<dev-libs/boost-1.46")

	boost_ver=${boost_ver/*boost-/}
	boost_ver=${boost_ver%.*}
	boost_ver=${boost_ver/./_}

	einfo "Using boost version ${boost_ver}"
	append-cxxflags \
		-I/usr/include/boost-${boost_ver}
	append-ldflags \
		-L/usr/$(get_libdir)/boost-${boost_ver}
	append-flags -DBOOST_FILESYSTEM_VERSION=2

	export BOOST_INCLUDEDIR="/usr/include/boost-${boost_ver}"
	export BOOST_LIBRARYDIR="/usr/$(get_libdir)/boost-${boost_ver}"
	sed -i -e 's/menuentry//' src/Makefile.am || die
	eautoreconf
}

src_install() {
	base_src_install
	newicon src/pics/cup2.png ${PN}.png
	make_desktop_entry ${PN}2 ClanBomber2
	rm -f "${D}${GAMES_DATADIR}"/${PN}/fonts/DejaVuSans-Bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf \
		"${GAMES_DATADIR}"/${PN}/fonts/
	prepgamesdirs
}
