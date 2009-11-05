# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/asteroid/asteroid-1.1.ebuild,v 1.5 2009/11/05 23:40:23 nyhm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A modern version of the arcade classic that uses OpenGL"
HOMEPAGE="http://chaoslizard.sourceforge.net/asteroid/"
SRC_URI="mirror://sourceforge/chaoslizard/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer"

PATCHES=( "${FILESDIR}"/${P}-include.patch )

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc asteroid-{authors,changes,readme}.txt
	prepgamesdirs
}
