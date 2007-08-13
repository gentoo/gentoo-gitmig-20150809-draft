# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bub-n-bros/bub-n-bros-1.5.ebuild,v 1.2 2007/08/13 19:14:10 coldwind Exp $

inherit eutils games

MY_P=${P/-n-}
DESCRIPTION="A multiplayer clone of the famous Bubble Bobble game"
HOMEPAGE="http://bub-n-bros.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="dev-python/pygame"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-home.patch
	epatch "${FILESDIR}"/${P}-python25.patch
}

src_compile() {
	# Compile the "statesaver" extension module to enable the Clock bonus
	cd "${S}"/bubbob
	python setup.py build_ext -i || die

	# Compile the extension module required for the X Window client
	cd "${S}"/display
	python setup.py build_ext -i || die

	# Build images
	cd "${S}"/bubbob/images
	python buildcolors.py || die
}

src_install() {
	local dir=$(games_get_libdir)/${PN}

	exeinto "${dir}"
	doexe *.py || die "doexe failed"

	insinto "${dir}"
	doins -r bubbob common display java http2 metaserver || die "doins failed"

	dodir "${GAMES_BINDIR}"
	dosym "${dir}"/BubBob.py "${GAMES_BINDIR}"/bubnbros || die "dosym failed"

	newicon http2/data/bob.png ${PN}.png
	make_desktop_entry bubnbros Bub-n-Bros

	rm -rf $(find "${D}/${dir}" -name CVS -type d)
	prepgamesdirs
}
