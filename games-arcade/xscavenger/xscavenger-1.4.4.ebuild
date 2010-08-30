# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xscavenger/xscavenger-1.4.4.ebuild,v 1.8 2010/08/30 14:42:08 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Lode-Runner-like arcade game"
HOMEPAGE="http://www.xdr.com/dash/scavenger.html"
SRC_URI="http://www.xdr.com/dash/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-misc/imake"

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}/${PV}-gentoo.patch"
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}:" \
		-e "s:GENTOO_BINDIR:${GAMES_BINDIR}:" \
		Imakefile \
		|| die "sed src/names.h failed"
}

src_configure() {
	xmkmf || die "xmkmf failed"
}

src_compile() {
	emake EXTRA_LDOPTIONS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ../{CREDITS,DOC,README,TODO,changelog}
	prepgamesdirs
}
