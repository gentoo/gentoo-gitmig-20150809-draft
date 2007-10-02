# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-4.2.ebuild,v 1.3 2007/10/02 03:51:36 dirtyepic Exp $

inherit eutils python multilib games

MY_PN=TuxMathScrabble
MY_P=${MY_PN}-0.${PV}LIN
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

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f $(find . -name '*.pyc')
	rm -rf $(find . -name '.svn')
	mv -f ${MY_PN}/accounts .
	sed -i "s:'/','var','games':'${GAMES_STATEDIR}':" \
		asymptopia_0_1_0/environment.py \
		|| die "sed failed"
}

src_install() {
	newgamesbin ${MY_PN}.py ${PN} || die "newgamesbin failed"

	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	doins -r ${MY_PN} || die "doins ${MY_PN} failed"
	doins -r asymptopia_0_1_0 || die "doins asymptopia_0_1_0 failed"

	insinto "${GAMES_STATEDIR}"/${MY_PN}
	doins -r accounts || die "doins accounts failed"

	newicon tms.ico ${PN}.ico
	make_desktop_entry ${PN} ${MY_PN} /usr/share/pixmaps/${PN}.ico

	dodoc CHANGES README
	prepgamesdirs
	fperms -R g+w "${GAMES_STATEDIR}"/${MY_PN}
}
