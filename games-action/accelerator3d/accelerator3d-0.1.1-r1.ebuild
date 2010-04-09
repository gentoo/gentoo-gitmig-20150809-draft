# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/accelerator3d/accelerator3d-0.1.1-r1.ebuild,v 1.2 2010/04/09 19:14:40 phajdan.jr Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Fast-paced, 3D, first-person shoot/dodge-'em-up, in the vain of Tempest or n2o"
HOMEPAGE="http://accelerator3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/accelerator3d/accelerator-${PV}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/pyode
	dev-python/pygame
	dev-python/pyopengl
	virtual/python"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo-paths.patch \
		"${FILESDIR}"/${P}-gllightmodel.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		accelerator.py || die
}

src_install() {
	newgamesbin accelerator.py accelerator || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins gfx/* snd/* || die "doins failed"
	dodoc CHANGELOG README
	prepgamesdirs
}
