# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-cep/nwn-cep-1.52.ebuild,v 1.2 2006/04/21 14:51:31 wolf31o2 Exp $

inherit games

DESCRIPTION="The Community Expansion Pack is a high quality custom content addon
for Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/players/cep.html"
SRC_URI="cepv${PV//.}_man.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="fetch"

DEPEND="app-arch/unzip"
RDEPEND=">=games-rpg/nwn-1.66"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit http://nwvault.ign.com/cep/downloads/"
	einfo "and download the .zip version."
	einfo "Then move the file you download to:"
	einfo "${DISTDIR}/${A}"
}

src_install() {
	dodir "${GAMES_PREFIX_OPT}"/nwn/{hak,tlk,modules,cep}
	cp *.hak "${D}/${GAMES_PREFIX_OPT}"/nwn/hak/ || die "hak failed"

	cp Live/* "${D}/${GAMES_PREFIX_OPT}"/nwn/hak/ || die "hak2 failed"
	cp cep.tlk "${D}/${GAMES_PREFIX_OPT}"/nwn/tlk/ || die "tlk failed"
	cp *.mod "${D}/${GAMES_PREFIX_OPT}"/nwn/modules/ || die "mod failed"
	cp *.pdf *.txt "${D}/${GAMES_PREFIX_OPT}"/nwn/cep/ || die "docs failed"
	prepgamesdirs
}
