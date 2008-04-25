# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/thinktanks-demo/thinktanks-demo-1.1-r1.ebuild,v 1.1 2008/04/25 21:52:14 tupone Exp $

inherit eutils games

DESCRIPTION="tank combat game with lighthearted, fast paced pandemonium"
HOMEPAGE="http://www.garagegames.com/pg/product/view.php?id=12"
SRC_URI="ftp://ggdev-1.homelan.com/thinktanks/ThinkTanksDemo_v${PV}.sh.bin"

LICENSE="THINKTANKS"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="strip"
IUSE=""

DEPEND=""
RDEPEND="media-libs/libsdl
	media-libs/libvorbis"

GAMES_CHECK_LICENSE="yes"
S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir "${dir}" "${GAMES_BINDIR}"

	tar -zxf ThinkTanks.tar.gz -C "${D}/${dir}" || die "extracting ThinkTanks.tar.gz"

	exeinto "${dir}"
	doexe bin/Linux/x86/thinktanksdemo
	dosym "${dir}"/thinktanksdemo "${GAMES_BINDIR}"/thinktanks-demo
	# Using system libraries
	rm -rf "${D}/${dir}"/lib

	insinto "${dir}"
	doins icon.xpm

	dodoc ReadMe_Linux.txt

	prepgamesdirs
}
