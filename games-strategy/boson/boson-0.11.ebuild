# Copyright 1999-2006 Gentoo Foundation and Thomas Capricelli <orzel@kde.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boson/boson-0.11.ebuild,v 1.4 2006/05/12 15:42:10 wolf31o2 Exp $

inherit kde

DESCRIPTION="real-time strategy game, with the feeling of Command&Conquer(tm) (needs at least 2 ppl to play)"
HOMEPAGE="http://boson.sourceforge.net/"
SRC_URI="mirror://sourceforge/boson/boson-all-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -sparc x86"
IUSE="opengl"

DEPEND="media-libs/lib3ds
	>=media-libs/openal-20040303
	<media-libs/openal-20051024
	kde-base/arts
	opengl? ( virtual/opengl )"
need-kde 3

S=${WORKDIR}/${PN}-all-${PV}

src_compile() {
	myconf="$(use_with opengl gl)"
	MAKEOPTS="${MAKEOPTS} -j1"

	kde_src_compile
}
