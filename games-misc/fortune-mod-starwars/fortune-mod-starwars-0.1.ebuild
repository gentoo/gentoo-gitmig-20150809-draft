# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-starwars/fortune-mod-starwars-0.1.ebuild,v 1.1 2003/09/10 18:14:05 vapier Exp $

S=${WORKDIR}/${PN/mod-/}
DESCRIPTION="Quotes from StarWars, The Empire Strikes Back, and Return of the Jedi"
SRC_URI="http://www.splitbrain.org/Fortunes/starwars/fortune-starwars.tgz"
HOMEPAGE="http://www.splitbrain.org/index.php?x=.%2FFortunes%2Fstarwars"

SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND="app-games/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins starwars starwars.dat
}
