# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-cep/nwn-cep-1.52-r1.ebuild,v 1.2 2006/04/21 14:51:31 wolf31o2 Exp $

inherit games

DESCRIPTION="The Community Expansion Pack is a high quality custom content addon for Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/players/cep.html"
SRC_URI="cepv${PV//.}_man.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="hou sou"
RESTRICT="fetch"

DEPEND="app-arch/unzip"
RDEPEND=">=games-rpg/nwn-1.66-r1"

S=${WORKDIR}

die_from_busted_nwn-data() {
	local use=$*
	ewarn "You must emerge games-rpg/nwn-data with USE=$use.  You can fix this"
	ewarn "by doing the following:"
	echo
	einfo "mkdir -p /etc/portage"
	einfo "echo 'games-rpg/nwn-data $use' >> /etc/portage/package.use"
	einfo "emerge --oneshot games-rpg/nwn-data"
	die "nwn-data requires USE=$use"
}

pkg_nofetch() {
	einfo "Please visit http://nwvault.ign.com/cep/downloads/"
	einfo "and download the .zip version."
	einfo "Then move the file you download to:"
	einfo "${DISTDIR}/${A}"
}

pkg_setup() {
	games_pkg_setup
	if use sou
	then
		built_with_use games-rpg/nwn-data sou || die_from_busted_nwn-data sou
	fi
	if use hou
	then
		built_with_use games-rpg/nwn-data hou || die_from_busted_nwn-data hou
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
