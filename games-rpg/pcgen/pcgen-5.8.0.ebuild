# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/pcgen/pcgen-5.8.0.ebuild,v 1.2 2006/07/08 23:34:32 tcort Exp $

inherit games

MY_PV="${PV//.}"
DESCRIPTION="D&D character generator"
HOMEPAGE="http://pcgen.sourceforge.net"
SRC_URI="mirror://sourceforge/pcgen/pcgen${MY_PV}_full.zip
	mirror://sourceforge/pcgen/skin.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND="|| (
	>=virtual/jdk-1.3.1
	>=virtual/jre-1.3.1 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack pcgen${MY_PV}_full.zip
	cd "${S}"
	mv pcgen${MY_PV} ${PN}
	cd pcgen
	unpack skin.zip
	# bat file? bat file?  We don't need no stinking bat file.
	rm pcgen.bat pcgen_high_mem.bat
	sed -i \
		"/dirname/ c\cd \"${GAMES_DATADIR}\/${PN}\"" \
		pcgen.sh \
		|| die "sed pcgen.sh failed"
	mv pcgen.sh "${T}/pcgen" || die "mv failed"
	echo "pcgen.filepaths=user" > "${S}/pcgen/filepaths.ini" \
		|| die "filepaths.ini creation failed"
}

src_install() {
	dogamesbin "${T}/pcgen" || die "dogamesbin failed"
	cd "${S}"/pcgen
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R "${WORKDIR}"/* "${D}/${GAMES_DATADIR}" || die "cp failed"
	keepdir "${GAMES_DATADIR}/${PN}/characters"
	prepgamesdirs
}
