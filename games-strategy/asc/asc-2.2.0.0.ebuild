# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/asc/asc-2.2.0.0.ebuild,v 1.3 2009/01/20 07:31:11 mr_bones_ Exp $

EAPI=2
inherit toolchain-funcs flag-o-matic games

DESCRIPTION="turn based strategy game designed in the tradition of the Battle Isle series"
HOMEPAGE="http://www.asc-hq.org/"
SRC_URI="mirror://sourceforge/asc-hq/${P}.tar.bz2
	http://www.asc-hq.org/music/frontiers.ogg
	http://www.asc-hq.org/music/time_to_strike.ogg
	http://www.asc-hq.org/music/machine_wars.ogg"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/bzip2
	media-libs/jpeg
	media-libs/libsdl
	media-libs/libpng
	media-libs/sdl-image[gif,jpeg,png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-sound
	dev-libs/boost
	dev-games/physfs
	media-libs/libvorbis
	media-libs/xvid
	dev-libs/expat
	media-libs/freetype
	dev-libs/libsigc++:1.2"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig"

src_unpack() {
	local f

	unpack ${P}.tar.bz2
	for f in ${A}
	do
		case ${f} in
		*ogg)
			cp "${DISTDIR}/${f}" "${S}/data/music" || die "cp music failed"
			;;
		esac
	done
}

src_configure() {
	# Added --disable-paraguitest for bugs 26402 and 4488
	# Added --disable-paragui for bug 61154 since it's not really used much
	# and the case is well documented at http://www.asc-hq.org/
	if [[ $(gcc-major-version) -eq 4 ]] ; then
		replace-flags -O3 -O2
	fi
	egamesconf \
		--disable-dependency-tracking \
		--disable-paraguitest \
		--disable-paragui \
		--datadir="${GAMES_DATADIR_BASE}" \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml -r doc/*
	prepgamesdirs
}
