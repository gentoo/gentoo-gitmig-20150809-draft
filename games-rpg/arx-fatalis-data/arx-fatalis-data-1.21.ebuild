# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/arx-fatalis-data/arx-fatalis-data-1.21.ebuild,v 1.1 2012/06/29 21:48:09 hasufell Exp $

EAPI=4

CDROM_OPTIONAL="yes"

inherit eutils cdrom check-reqs games

DESCRIPTION="Arx Fatalis data files"
HOMEPAGE="http://www.arkane-studios.com/uk/arx.php"
SRC_URI="http://download.zenimax.com/arxfatalis/patches/1.21/ArxFatalis_1.21_MULTILANG.exe"

LICENSE="ArxFatalis-EULA-JoWooD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="games-rpg/arx-libertatis"
DEPEND="app-arch/cabextract
	app-arch/innoextract"

CHECKREQS_DISK_BUILD="621M"
CHECKREQS_DISK_USR="617M"

S=${WORKDIR}

src_unpack() {
	cdrom_get_cds bin/data2.pak

	find "${CDROM_ROOT}" -iname "setup*.cab" -exec cabextract '{}' \;
	innoextract --lowercase --language=multilang \
		"${DISTDIR}"/ArxFatalis_1.21_MULTILANG.exe || die
}

src_install() {
	insinto "${GAMES_DATADIR}"/arx
	doins -r app/{graph,misc,data2.pak} *.pak "${CDROM_ROOT}"/bin/LOC.pak
	dodoc app/{manual,map}.pdf

	# convert to lowercase
	find "${D}" -type f -exec sh -c 'echo "${1}"
	lower="`echo "${1}" | tr [:upper:] [:lower:]`"
	[ "${1}" = "${lower}" ] || mv "${1}" "${lower}"' - {} \;

	prepgamesdirs
}
