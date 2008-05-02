# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quadra/quadra-1.1.8.ebuild,v 1.19 2008/05/02 22:35:13 nyhm Exp $

inherit eutils games

DESCRIPTION="A tetris clone with multiplayer support"
HOMEPAGE="http://quadra.sourceforge.net/"
SRC_URI="mirror://sourceforge/quadra/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="svga"

RDEPEND="x11-libs/libXpm
	media-libs/libpng
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-gcc3.patch \
		"${FILESDIR}"/libpng-1.2.5.patch \
		"${FILESDIR}"/${P}-amd64.patch \
		"${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-gcc42.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e 's:-pedantic::' config/vars.mk \
			|| die "sed config/vars.mk failed"
	sed -i \
		-e "/^libgamesdir:=/s:/games:/${PN}:" \
		-e "/^datagamesdir:=/s:/games:/${PN}:" config/config.mk.in \
			|| die "sed config/config.mk.in failed"
}

src_compile() {
	# configure script is coded only to accept --without-svgalib
	# --with-svgalib is bugged
	# raised bug #1433828 @ quadra - Sourceforge
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1433828&group_id=7275&atid=107275
	if use svga; then
		egamesconf || die
	else
		egamesconf --without-svgalib || die
	fi
	emake || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	if use svga; then
		dogameslib.so ${PN}-svga.so || die "dogameslib.so failed"
	fi
	insinto "${GAMES_DATADIR}"/${PN}
	doins ${PN}.res || die "doins failed"
	doicon images/${PN}.xpm
	make_desktop_entry ${PN} Quadra

	dodoc ChangeLog NEWS README
	dohtml help/*
	prepgamesdirs
}
