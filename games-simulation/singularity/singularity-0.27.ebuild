# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/singularity/singularity-0.27.ebuild,v 1.1 2008/04/18 19:25:01 mr_bones_ Exp $

inherit eutils games

MUSIC=endgame-${PN}-music-005

DESCRIPTION="A simulation of a true AI. Go from computer to computer, pursued by the entire world. Keep hidden, and you might have a chance."
HOMEPAGE="http://www.emhsoft.com/singularity/"
SRC_URI="http://www.emhsoft.com/singularity/${PN}_${PV}.tar.gz
	music? ( http://endgame-singularity.googlecode.com/files/${MUSIC}.zip )"

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="music"

RDEPEND="dev-python/pygame"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -f code/*.pyc data/*.html # Remove unecessary files
}

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r code data || die "doins failed"
	if use music ; then
		doins -r ../${MUSIC}/music || die "doins failed"
	fi
	games_make_wrapper singularity "python ./singularity.py" "${GAMES_DATADIR}/${PN}/code"
	dodoc README.txt TODO Changelog AUTHORS
	prepgamesdirs
}
