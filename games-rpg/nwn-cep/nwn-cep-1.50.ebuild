# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-cep/nwn-cep-1.50.ebuild,v 1.1 2005/01/20 06:48:15 vapier Exp $

inherit games

DESCRIPTION="The Community Expansion Pack is a high quality custom content addon"
HOMEPAGE="http://nwn.bioware.com/players/cep.html"
SRC_URI="cepv${PV//.}man.rar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="fetch"

DEPEND="app-arch/unrar"
RDEPEND=">=games-rpg/nwn-1.65"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit http://nwvault.ign.com/cep/downloads/"
	einfo "and download the .rar version."
	einfo "Then move the file you download to:"
	einfo "${DISTDIR}/${A}"
}

src_unpack() {
	unrar x "${DISTDIR}"/${A} || die "unpacking ${A}"
}

src_install() {
	dodir "${GAMES_PREFIX_OPT}"/nwn/{hak,tlk,modules,cep}
	mv *.hak "${D}/${GAMES_PREFIX_OPT}"/nwn/hak/ || die "hak failed"
	local hak cep
	if has_version games-rpg/nwn-hotu ; then
		hak=HotU
		cep="Live SoU"
	elif has_version games-rpg/nwn-sou ; then
		hak=SoU
		cep="Live HotU"
	else
		hak=Live
		cep="HotU SoU"
	fi
	mv ${hak}/* "${D}/${GAMES_PREFIX_OPT}"/nwn/hak/ || die "hak2 failed"
	mv ${cep} "${D}/${GAMES_PREFIX_OPT}"/nwn/cep/ || die "cep failed"
	mv cep.tlk "${D}/${GAMES_PREFIX_OPT}"/nwn/tlk/ || die "tlk failed"
	mv *.mod "${D}/${GAMES_PREFIX_OPT}"/nwn/modules/ || die "mod failed"
	mv *.pdf *.txt "${D}/${GAMES_PREFIX_OPT}"/nwn/cep/ || die "docs failed"
	prepgamesdirs
}
