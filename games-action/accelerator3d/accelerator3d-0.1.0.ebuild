# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/accelerator3d/accelerator3d-0.1.0.ebuild,v 1.1 2005/10/22 05:58:25 vapier Exp $

inherit games eutils

DESCRIPTION="Fast-paced, 3D, first-person shoot/dodge-'em-up, in the vain of Tempest or n2o"
HOMEPAGE="http://accelerator3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/accelerator3d/accelerator-${PV}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyode
	dev-python/pygame
	dev-python/pyopengl
	virtual/python"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo-paths.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		accelerator.py || die
}

src_install() {
	newgamesbin accelerator.py accelerator || die "gamesbin"
	insinto "${GAMES_DATADIR}"/${PN}
	doins gfx/* || die "doins gfx"
	dodoc CHANGELOG README
	prepgamesdirs
}
