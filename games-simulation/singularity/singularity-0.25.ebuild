# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/singularity/singularity-0.25.ebuild,v 1.1 2006/08/14 06:45:52 mr_bones_ Exp $

inherit games

DESCRIPTION="A simulation of a true AI. Go from computer to computer, pursued by the entire world. Keep hidden, and you might have a chance."
HOMEPAGE="http://www.emhsoft.net/singularity/"
SRC_URI="http://www.emhsoft.net/singularity/${PN}_${PV}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-python/pygame"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	rm code/*.pyc data/*.html # Remove unecessary files
}

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r code data || die "doins failed"
	games_make_wrapper singularity "python ./singularity.py" "${GAMES_DATADIR}/${PN}/code"
	dodoc README.txt TODO Changelog AUTHORS
	prepgamesdirs
}
