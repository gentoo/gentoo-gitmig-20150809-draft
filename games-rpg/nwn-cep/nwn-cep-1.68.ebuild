# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-cep/nwn-cep-1.68.ebuild,v 1.1 2006/10/05 17:52:07 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="a high quality custom content addon for Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/players/cep.html"
SRC_URI="cepv152_man.zip cepv153.zip CEP168.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch"

DEPEND="app-arch/unzip"
RDEPEND="~games-rpg/nwn-1.68"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit http://nwvault.ign.com/cep/downloads/"
	einfo "and download the .zip versions of ${A}."
	einfo "Then move the files you downloaded to:"
	einfo "${DISTDIR}"
}

pkg_setup() {
	games_pkg_setup
	if ! built_with_use games-rpg/nwn-data sou || ! built_with_use games-rpg/nwn-data hou
	then
		eerror "${P} requires NWN v1.68, Shadows of Undrentide, and Hordes of"
		eerror "the Underdark. Please make sure you have all three before using"
		eerror "this patch."
		die "Requirements not met"
	fi
}

src_install() {
	dodir "${GAMES_PREFIX_OPT}"/nwn/{hak,tlk,modules,cep}
	cp *.hak "${D}/${GAMES_PREFIX_OPT}"/nwn/hak/ || die "hak failed"

	local hak
	if use hou ; then
		hak=HotU
	elif use sou ; then
		hak=SoU
	else
		hak=Live
	fi

	cp ${hak}/* "${D}/${GAMES_PREFIX_OPT}"/nwn/hak/ || die "hak2 failed"
	cp cep.tlk "${D}/${GAMES_PREFIX_OPT}"/nwn/tlk/ || die "tlk failed"
	cp *.mod "${D}/${GAMES_PREFIX_OPT}"/nwn/modules/ || die "mod failed"
	cp *.pdf *.txt "${D}/${GAMES_PREFIX_OPT}"/nwn/cep/ || die "docs failed"
	prepgamesdirs
}
