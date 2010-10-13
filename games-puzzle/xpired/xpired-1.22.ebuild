# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xpired/xpired-1.22.ebuild,v 1.10 2010/10/13 07:53:56 tupone Exp $
EAPI="2"

inherit eutils games

DESCRIPTION="A Sokoban-styled puzzle game with lots more action."
HOMEPAGE="http://xpired.sourceforge.net"
SRC_URI="mirror://sourceforge/xpired/${P}-linux_source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}"

S=${WORKDIR}/src

PATCHES=( "${FILESDIR}"/${P}-ldflags.patch )

src_compile() {
	emake PREFIX=/usr/games SHARE_PREFIX=/usr/share/games/xpired || \
		die "emake failed"
}
src_install() {
	make \
		PREFIX="${D}/usr/games" \
		SHARE_PREFIX="${D}/usr/share/games/${PN}" \
		install || die "make install failed"
	prepgamesdirs
}
