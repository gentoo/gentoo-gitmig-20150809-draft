# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/londonlaw/londonlaw-0.2.1-r1.ebuild,v 1.1 2008/01/05 00:47:38 dirtyepic Exp $

inherit eutils python games

DESCRIPTION="Clone of the famous Scotland Yard board game"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/londonlaw/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/londonlaw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	=dev-python/wxpython-2.6*
	dev-python/twisted"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-setup.py.patch"
	epatch "${FILESDIR}"/${P}-wxversion.patch
}

src_install() {
	python_version
	python setup.py install \
		--root="${D}" \
		--prefix="${GAMES_PREFIX}" \
		--install-lib=/usr/lib/python${PYVER}/site-packages \
		--install-data="${GAMES_DATADIR}" \
		|| die "install failed"
	dodoc ChangeLog README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "To play, first start the server (london-server), then connect"
	elog "with the client (london-client).  At least two players are"
	elog "needed to play."
	echo
}
