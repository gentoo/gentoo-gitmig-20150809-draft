# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dark-oberon/dark-oberon-1.0.2_rc1.ebuild,v 1.1 2007/01/16 16:21:18 tupone Exp $

inherit eutils games

MY_PV=${PV/_rc/-RC}
MY_P=${PN}-${MY_PV}

DESCRIPTION="a Warcraft like RTS game"
HOMEPAGE="http://dark-oberon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="fmod"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/glfw
	fmod? ( media-libs/fmod )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-gentoo.patch
}

src_compile() {
	cd src
	if use fmod; then
		emake SOUND=1 ../${PN} || die "emake failed"
	else
		emake ../${PN} || die "emake failed"
	fi
}

src_install() {
	dogamesbin dark-oberon || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r dat maps races schemes || die "doins failed"
	dodoc README docs/* || die "dodoc failed"

	prepgamesdirs
}
