# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bub-n-bros/bub-n-bros-1.1.ebuild,v 1.10 2005/08/11 23:54:26 tester Exp $

inherit games

DESCRIPTION="A multiplayer clone of the famous Bubble Bobble game"
HOMEPAGE="http://bub-n-bros.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"
RDEPEND=">=dev-python/pygame-1.5.5"

S="${WORKDIR}/${PN}"

src_compile() {
	# Compile the "statesaver" extension module to enable the Clock bonus
	cd ${S}/bubbob
	python setup.py build_ext -i || die

	# Compile the extension module required for the X Window client
	cd ${S}/display
	python setup.py build_ext -i || die
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}

	exeinto ${dir}
	doexe *.py

	insinto ${dir}
	cp -r bubbob common display java ${D}/${dir}/

	dodir ${GAMES_BINDIR}
	dosym ${dir}/pclient-pygame.py ${GAMES_BINDIR}/bubnbros
	dosym ${dir}/pclient-xshm.py ${GAMES_BINDIR}/bubnbros-x
	dosym ${dir}/pclient-slow-X.py ${GAMES_BINDIR}/bubnbros-slowx

	dogamesbin ${FILESDIR}/bubnbros-server
	dosed "s:GENTOO_DIR:${dir}/bubbob/:" ${GAMES_BINDIR}/bubnbros-server

	dohtml *.html

	find ${D}/${dir} -name CVS -type d -exec rm -rf '{}' \; 2> /dev/null

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "First you must start a server by running \`bubnbros-server\`."
	einfo "Afterwards you can start the client by running \`bubnbros\`"
	einfo "or \`bubnbros-x\`.  Note that the X version of the game"
	einfo "doesn't support sound and music."
}
