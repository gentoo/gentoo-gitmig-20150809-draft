# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/gslist/gslist-0.8.8.ebuild,v 1.2 2009/10/29 14:29:39 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A GameSpy server browser"
HOMEPAGE="http://aluigi.altervista.org/papers.htm#gslist"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="web"

RDEPEND="dev-libs/geoip"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}

src_prepare() {
	emake clean
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake SQL=0 $(use web || echo GSWEB=0) || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc ${PN}.txt
	prepgamesdirs
}
