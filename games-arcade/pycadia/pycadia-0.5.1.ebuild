# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pycadia/pycadia-0.5.1.ebuild,v 1.6 2004/11/08 01:43:41 josejx Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="Pycadia. Home to vector gaming, python style."
HOMEPAGE="http://www.anti-particle.com/pycadia.shtml"
SRC_URI="http://www.anti-particle.com/downloads/${P}.tar.gz"

KEYWORDS="x86 ~amd64 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-python/pygame-1.5.5
	>=dev-python/pygtk-1.99.16"

src_install() {
	local dir="${GAMES_DATADIR}/${PN}"

	insinto "${dir}"
	doins *.py pycadia.conf || die "doins failed"

	exeinto "${dir}"
	doexe pycadia.py spacewarpy.py vektoroids.py || die "doexe failed"

	cp -R {glade,pixmaps,sounds} "${D}/${dir}" || die "cp failed"

	echo "#!/bin/sh" > pycadia
	echo "cd ${dir}" >> pycadia
	echo "exec python ./pycadia.py \"\${@}\"" >> pycadia
	dogamesbin pycadia || die "dogamesbin failed"
	dodoc doc/TODO doc/CHANGELOG doc/README || die "dodoc failed"
	prepgamesdirs
}
