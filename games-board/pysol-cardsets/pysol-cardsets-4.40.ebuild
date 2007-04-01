# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol-cardsets/pysol-cardsets-4.40.ebuild,v 1.1 2007/04/01 21:41:02 tupone Exp $

inherit games

DESCRIPTION="Extra cardsets for pysol game"
HOMEPAGE="http://packages.debian.org/stable/games/pysol-cardsets"
SRC_URI="http://ftp.debian.org/debian/pool/main/p/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"/data

	# Removing cardsets already shipped with pysol package
	for cardset in cardset-2000 cardset-colossus cardset-hard-a-port \
		cardset-hexadeck cardset-kintengu cardset-oxymoron cardset-tuxedo \
		cardset-vienna-2k ; do
		rm -rf $cardset
	done
}

src_install() {
	insinto "${GAMES_DATADIR}/pysol"
	doins -r data/* || die "Installing cardsets failed"
	dodoc NEWS README || die "Doc installation failed"

	prepgamesdirs
}
