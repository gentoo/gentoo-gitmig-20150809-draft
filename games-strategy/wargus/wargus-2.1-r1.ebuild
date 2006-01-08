# Copyright 2004-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wargus/wargus-2.1-r1.ebuild,v 1.2 2006/01/08 00:59:07 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Warcraft II for the Stratagus game engine (Needs WC2 DOS CD)"
HOMEPAGE="http://wargus.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz
	http://dev.gentoo.org/~genstef/files/wargus.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libpng
	sys-libs/zlib"
RDEPEND="=games-engines/stratagus-${PV:0:3}*"

pkg_setup() {
	cdrom_get_cds data/rezdat.war
	games_pkg_setup
}

src_unpack() {
	unpack ${P}-src.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/wargus-2.1-humanbasespell.patch \
		"${FILESDIR}"/wargus-2.1-ai.patch \
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
