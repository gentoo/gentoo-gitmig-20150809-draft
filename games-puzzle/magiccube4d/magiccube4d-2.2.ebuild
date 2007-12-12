# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/magiccube4d/magiccube4d-2.2.ebuild,v 1.12 2007/12/12 02:11:06 mr_bones_ Exp $

inherit eutils games

MY_PV=${PV/./_}
DESCRIPTION="four-dimensional analog of Rubik's cube"
HOMEPAGE="http://www.superliminal.com/cube/cube.htm"
SRC_URI="http://www.superliminal.com/cube/mc4d-src-${MY_PV}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/libXaw"

S="${WORKDIR}/${PN}-src-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-EventHandler.patch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-64bit-ptr.patch
	sed -i \
		-e "s:-Werror::" \
		configure \
		|| die "sed failed"
}

src_compile() {
	egamesconf || die
	emake DFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin magiccube4d || die "dogamesbin failed"
	dodoc ChangeLog MagicCube4D-unix.txt readme-unix.txt Intro.txt
	prepgamesdirs
}
