# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/pcgen/pcgen-5.10.1.ebuild,v 1.2 2007/07/23 23:28:01 nyhm Exp $

inherit versionator games

MY_PV=$(delete_all_version_separators)
DESCRIPTION="D&D character generator"
HOMEPAGE="http://pcgen.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcgen/pcgen${MY_PV}_full.zip"

LICENSE="LGPL-2 OGL-1.0a"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND="app-arch/unzip"

S=${WORKDIR}/pcgen${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f *.bat
	sed -i "/dirname/ c\cd \"${GAMES_DATADIR}\/${PN}\"" \
		pcgen.sh \
		|| die "sed pcgen.sh failed"
	echo "pcgen.filepaths=user" > "${S}/filepaths.ini" \
		|| die "filepaths.ini creation failed"
}

src_install() {
	newgamesbin pcgen{.sh,} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r * || die "doins failed"
	keepdir "${GAMES_DATADIR}/${PN}/characters"
	prepgamesdirs
}
