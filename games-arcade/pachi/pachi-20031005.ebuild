# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pachi/pachi-20031005.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

S="${WORKDIR}/Pachi"
DESCRIPTION="A platforms game inspired by games like Manic Miner and Jet Set Willy"
# Upstream doesn't version their releases.
# I downloaded and re-compressed with tar -jcvf
#SRC_URI="mirror://sourceforge/dragontech/pachi_source.tgz"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://dragontech.sourceforge.net/index.php?main=pachi&lang=en"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

RDEPEND=">=media-libs/libsdl-1.2
	media-libs/sdl-mixer
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:/var/lib/games/:${GAMES_STATEDIR}/:" configure.in || \
			die "sed configure.in failed"
}

src_install() {
	local dir="${GAMES_DATADIR}/${PN}"
	local statedir="${GAMES_STATEDIR}/${PN}/data"

	dogamesbin src/pachi
	insinto ${dir}/data
	doins data/{backs,monsters,objects_v2,rooms_v2}.dat
	insinto ${dir}/fonts
	doins fonts/*.T
	insinto ${dir}/music
	doins music/*.s?m
	insinto ${dir}/sounds
	doins sounds/*.wav
	insinto ${dir}/Tgfx
	doins Tgfx/*.{T8,bmp}
	dodoc AUTHORS ChangeLog
	insinto ${statedir}
	doins data/scores.dat
	prepgamesdirs
	fperms 660 ${statedir}/scores.dat
}
