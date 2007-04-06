# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bub-n-bros/bub-n-bros-1.1.ebuild,v 1.12 2007/04/06 00:08:25 nyhm Exp $

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

S=${WORKDIR}/${PN}

src_compile() {
	# Compile the "statesaver" extension module to enable the Clock bonus
	cd "${S}"/bubbob
	python setup.py build_ext -i || die

	# Compile the extension module required for the X Window client
	cd "${S}"/display
	python setup.py build_ext -i || die
}

src_install() {
	local dir=$(games_get_libdir)/${PN}

	exeinto "${dir}"
	doexe *.py || die "doexe failed"

	insinto "${dir}"
	doins -r bubbob common display java || die "doins failed"

	dodir "${GAMES_BINDIR}"
	dosym "${dir}"/pclient-pygame.py "${GAMES_BINDIR}"/bubnbros
	dosym "${dir}"/pclient-xshm.py "${GAMES_BINDIR}"/bubnbros-x
	dosym "${dir}"/pclient-slow-X.py "${GAMES_BINDIR}"/bubnbros-slowx

	games_make_wrapper bubnbros-server "python ./bb.py" "${dir}"/bubbob

	dohtml *.html

	find "${D}/${dir}" -name CVS -type d -exec rm -rf '{}' \; 2> /dev/null

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "First you must start a server by running \`bubnbros-server\`."
	elog "Afterwards you can start the client by running \`bubnbros\`"
	elog "or \`bubnbros-x\`.  Note that the X version of the game"
	elog "doesn't support sound and music."
}
