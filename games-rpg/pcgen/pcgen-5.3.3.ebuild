# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/pcgen/pcgen-5.3.3.ebuild,v 1.1 2003/09/12 00:52:27 vapier Exp $

inherit games

MY_PV="${PV//./}"
S=${WORKDIR}
DESCRIPTION="D&D character generator"
HOMEPAGE="http://pcgen.sourceforge.net"
SRC_URI="mirror://sourceforge/pcgen/pcgen${MY_PV}_part1of3.zip
	mirror://sourceforge/pcgen/pcgen${MY_PV}_part2of3.zip
	mirror://sourceforge/pcgen/pcgen${MY_PV}_part3of3.zip
	mirror://sourceforge/pcgen/skin.zip
	mirror://sourceforge/pcgen/pdf_new.zip"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="LGPL-2"
SLOT="0"
IUSE=""

RDEPEND="|| ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S}

	# bat file? bat file?  We don't need no stinking bat file.
	rm pcgen.bat
	sed -i \
		-e "/dirname/ c\cd \"${GAMES_DATADIR}\/${PN}\"" pcgen.sh || \
			die "sed pcgen.sh failed"
}

src_install() {
	local dir="${GAMES_DATADIR}/${PN}"

	newgamesbin pcgen.sh pcgen
	dodir "${dir}"
	cp -R ${WORKDIR}/* "${D}/${dir}"

	# don't need the shell script install here.
	rm "${D}/${dir}/pcgen.sh"

	echo pcgen.filepaths=user > "${D}/${dir}/filepaths.ini"
	prepgamesdirs
}
