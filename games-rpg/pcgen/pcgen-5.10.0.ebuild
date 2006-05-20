# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/pcgen/pcgen-5.10.0.ebuild,v 1.1 2006/05/20 08:24:15 mr_bones_ Exp $

inherit games

MY_PV="${PV//./}"
DESCRIPTION="D&D character generator"
HOMEPAGE="http://pcgen.sourceforge.net"
SRC_URI="mirror://sourceforge/pcgen/pcgen${MY_PV}_full.zip"

LICENSE="LGPL-2 OGL-1.0a"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="|| (
	>=virtual/jdk-1.3.1
	>=virtual/jre-1.3.1 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/pcgen

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv pcgen${MY_PV} ${PN}
	cd "${S}"
	# bat file? bat file?  We don't need no stinking bat file.
	rm -f *.bat
	sed -i \
		"/dirname/ c\cd \"${GAMES_DATADIR}\/${PN}\"" \
		pcgen.sh \
		|| die "sed pcgen.sh failed"
	mv pcgen.sh "${T}/pcgen" || die "mv failed"
	echo "pcgen.filepaths=user" > "${S}/filepaths.ini" \
		|| die "filepaths.ini creation failed"
}

src_install() {
	dogamesbin "${T}/pcgen" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"
	doins -r "${WORKDIR}"/${PN} || die "doins failed"
	keepdir "${GAMES_DATADIR}/${PN}/characters"
	prepgamesdirs
}
