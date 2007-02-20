# Copyright 2004-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wargus/wargus-2.1-r1.ebuild,v 1.6 2007/02/20 14:01:07 blubb Exp $

inherit eutils games

DESCRIPTION="Warcraft II for the Stratagus game engine (Needs WC2 DOS CD)"
HOMEPAGE="http://wargus.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz
	http://dev.gentoo.org/~genstef/files/wargus.png
	http://dev.gentoo.org/~genstef/files/dist/wargus-2.1-ai.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng
	sys-libs/zlib"
RDEPEND="=games-engines/stratagus-${PV:0:3}*"

src_unpack() {
	cdrom_get_cds data/rezdat.war
	unpack ${A/wargus.png}
	cd "${S}"
	epatch "${FILESDIR}"/wargus-2.1-humanbasespell.patch \
		"${WORKDIR}"/wargus-2.1-ai.patch \
		"${FILESDIR}"/wargus-2.1-aitransporter.patch
}

src_install() {
	local dir="${GAMES_DATADIR}/stratagus/${PN}"
	dodir "${dir}"
	./build.sh -p "${CDROM_ROOT}" -o "${D}/${dir}" -v \
		|| die "Failed to extract data"
	games_make_wrapper wargus "./stratagus -d \"${dir}\"" "${GAMES_BINDIR}"
	prepgamesdirs

	doicon "${DISTDIR}"/wargus.png
	make_desktop_entry wargus Wargus
}
