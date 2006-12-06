# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quadra/quadra-1.1.8.ebuild,v 1.15 2006/12/06 17:18:47 wolf31o2 Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="A tetris clone with multiplayer support"
HOMEPAGE="http://quadra.sourceforge.net/"
SRC_URI="mirror://sourceforge/quadra/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="svga"

RDEPEND="x11-libs/libXpm
	>=media-libs/libpng-1.2.1
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	[ $(gcc-major-version) -ge 3 ] && epatch "${FILESDIR}/${P}-gcc3.patch"
	epatch "${FILESDIR}/libpng-1.2.5.patch"
	use amd64 && epatch "${FILESDIR}/${P}-amd64.patch"
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
	dogamesbin ${PN}
	if use svga; then
		dogameslib.so ${PN}-svga.so
	fi
	insinto ${GAMES_DATADIR}/${PN}
	doins ${PN}.res
	doicon images/${PN}.xpm
	make_desktop_entry ${PN} "Quadra" ${PN}.xpm

	dodoc ChangeLog NEWS README
	dohtml help/*
	prepgamesdirs
}
