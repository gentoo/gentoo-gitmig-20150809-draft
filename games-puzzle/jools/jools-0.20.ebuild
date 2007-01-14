# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/jools/jools-0.20.ebuild,v 1.1 2007/01/14 03:02:45 tupone Exp $

inherit eutils python games

MUS_URI=${PN}-musicpack-1.0.tar.gz

DESCRIPTION="clone of Bejeweled, a popular pattern-matching game."
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/jools/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/jools/${P}.tar.gz
	 http://www.eecs.umich.edu/~pelzlpj/jools/${MUS_URI}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-python/pygame-1.4"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"/jools/music
	unpack ${MUS_URI}
	cd "${S}"
	echo "MEDIAROOT = \"${GAMES_DATADIR}/${PN}\"" > ${PN}/config.py
}

src_install() {
	dogamesbin ${PN}/${PN} || die "dogamesbin failed"

	python_version

	insinto /usr/lib/python${PYVER}/site-packages/${PN}
	doins ${PN}/*.py || die "Installing python files failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ${PN}/{fonts,images,music,sounds} \
		|| die "Installing data file failed"

	dodoc ChangeLog doc/{POINTS,TODO}
	dohtml doc/manual.html

	newicon ${PN}/images/ruby/0001.png ${PN}.png
	make_desktop_entry ${PN} "Jools" ${PN}.png

	prepgamesdirs
}
