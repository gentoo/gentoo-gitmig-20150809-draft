# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-killer/quake1-killer-2.2z.ebuild,v 1.1 2005/01/16 23:01:21 vapier Exp $

inherit games eutils

DESCRIPTION="The Killer Quake Patch"
HOMEPAGE="http://kqp.mpog.com/ http://www.planetquake.com/qca/reviews/patch143.htm"
SRC_URI="http://www.gamers.org/pub/idgames2/quakec/compilations/kqp220z.zip
	mirror://gentoo/kqp220z.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	echo ">>> Unpacking kqp220z.zip to ${PWD}"
	unzip -qoL "${DISTDIR}"/kqp220z.zip || die "unpacking kqp220z.zip failed"
}

src_install() {
	local dir=${GAMES_DATADIR}/quake-data/killer
	dodir "${dir}"
	insinto "${dir}"
	doins -r *
	prepgamesdirs
}
