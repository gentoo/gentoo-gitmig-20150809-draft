# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-3.0.4.ebuild,v 1.1 2006/11/01 12:02:48 tupone Exp $

inherit eutils python games

MY_PN="TuxMathScrabble"
MY_P=${MY_PN}-${PV}
DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://www.asymptopia.org/"
SRC_URI="mirror://sourceforge/tuxmathscrabble/${MY_P}LIN.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4.1
	>=dev-python/pygame-1.7
	>=dev-python/wxpython-2.6.1"

S=${WORKDIR}/${MY_P}LIN

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-wxVersion.patch
}

src_install() {
	python_version
	insinto "${GAMES_STATEDIR}"/${PN}
	doins -r ${PN}/accounts
	insinto /usr/lib/python${PYVER}/site-packages
	doins -r ${PN}
	rm -rf ${D}/usr/lib/python${PYVER}/site-packages/${PN}/accounts
	dodoc AUTHOR CHANGES
	newgamesbin ${MY_PN}.py ${PN}
	prepgamesdirs
	fperms -R u+rwX,g+rwX,o-rwx "${GAMES_STATEDIR}/${PN}"
}
