# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xscavenger/xscavenger-1.4.4.ebuild,v 1.4 2006/01/29 00:00:28 joshuabaergen Exp $

inherit eutils games

DESCRIPTION="Lode-Runner-like arcade game"
HOMEPAGE="http://www.xdr.com/dash/scavenger.html"
SRC_URI="http://www.xdr.com/dash/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="|| ( x11-libs/libXext virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-misc/imake virtual/x11 )
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo.patch"
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}:" \
		-e "s:GENTOO_BINDIR:${GAMES_BINDIR}:" \
		src/Imakefile \
		|| die "sed src/names.h failed"
}

src_compile() {
	cd src
	xmkmf || die "xmkmf failed"
	emake || die "emake failed"
}

src_install() {
	make -C src DESTDIR="${D}" install || die "make install failed"
	dodoc CREDITS DOC README TODO changelog
	prepgamesdirs
}
