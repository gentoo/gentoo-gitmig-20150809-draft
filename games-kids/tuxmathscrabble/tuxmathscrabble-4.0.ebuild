# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-4.0.ebuild,v 1.1 2007/07/22 01:33:35 nyhm Exp $

inherit eutils python multilib games

MY_PN="TuxMathScrabble"
MY_P=${MY_PN}-${PV}LIN
DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://www.asymptopia.org/"
SRC_URI="mirror://sourceforge/tuxmathscrabble/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/pygame
	dev-python/wxpython"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f $(find . -name '*.pyc')
	mv -f ${MY_PN}/accounts .
	sed -i "s:'/','var','games':'${GAMES_STATEDIR}':" EduApp/environment.py \
		|| die "sed failed"
}

src_install() {
	newgamesbin ${MY_PN}.py ${PN} || die "newgamesbin failed"

	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	doins -r ${MY_PN} || die "doins ${MY_PN} failed"
	doins -r EduApp || die "doins EduApp failed"

	insinto "${GAMES_STATEDIR}"/${MY_PN}
	doins -r accounts || die "doins accounts failed"

	newicon tms.ico ${PN}.ico
	make_desktop_entry ${PN} ${MY_PN} /usr/share/pixmaps/${PN}.ico

	dodoc CHANGES README
	prepgamesdirs
	fperms -R g+w "${GAMES_STATEDIR}"/${MY_PN}
}
