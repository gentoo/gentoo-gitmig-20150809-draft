# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-4.5.ebuild,v 1.3 2010/10/19 03:43:56 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit eutils python multilib games

MY_PN=TuxMathScrabble
MY_P=${MY_PN}-0.${PV}
DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://www.asymptopia.org/"
SRC_URI="http://www.asymptopia.org/software/${MY_P}.tgz
	mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/pygame
	=dev-python/wxpython-2.6*"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	rm -f $(find . -name '*.pyc')
	mv -f ${MY_PN}/{Accounts,Globals,Simulation,StudentData} .
	sed -i "s:'/','var','games':'${GAMES_STATEDIR}':" \
		asymptopia_0_1_3/environment.py \
		|| die "sed failed"
	python_convert_shebangs -r 2 .
}

src_install() {
	newgamesbin ${MY_PN}.py ${PN} || die "newgamesbin failed"

	insinto $(python_get_sitedir)
	doins -r ${MY_PN} || die "doins failed"
	doins -r asymptopia_0_1_3 || die "doins asymptopia_0_1_2 failed"

	insinto "${GAMES_STATEDIR}"/${MY_PN}
	doins -r Accounts Globals Simulation StudentData || die "doins failed"

	newicon tms.ico ${PN}.ico
	make_desktop_entry ${PN} ${MY_PN} /usr/share/pixmaps/${PN}.ico

	dodoc CHANGES README
	prepgamesdirs
	fperms -R g+w "${GAMES_STATEDIR}"/${MY_PN}
}
