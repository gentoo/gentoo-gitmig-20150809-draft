# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pycadia/pycadia-0.5.1.ebuild,v 1.14 2009/01/19 19:03:34 mr_bones_ Exp $

EAPI=1
inherit eutils games

DESCRIPTION="Pycadia. Home to vector gaming, python style."
HOMEPAGE="http://www.anti-particle.com/pycadia.shtml"
SRC_URI="http://www.anti-particle.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-python/pygame-1.5.5
	dev-python/pygtk:2"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	echo "#!/bin/sh" > "${T}/pycadia"
	echo "cd ${GAMES_DATADIR}/${PN}" >> "${T}/pycadia"
	echo "exec python ./pycadia.py \"\${@}\"" >> "${T}/pycadia"
}

src_install() {
	dogamesbin "${T}/pycadia" || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins *.py pycadia.conf || die "doins failed"
	doins -r {glade,pixmaps,sounds} || die "doins failed"

	exeinto "${GAMES_DATADIR}/${PN}"
	doexe pycadia.py spacewarpy.py vektoroids.py || die "doexe failed"

	dodoc doc/TODO doc/CHANGELOG doc/README
	prepgamesdirs
}
