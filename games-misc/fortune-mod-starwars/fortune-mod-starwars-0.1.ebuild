# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-starwars/fortune-mod-starwars-0.1.ebuild,v 1.8 2005/07/31 14:39:40 corsair Exp $

DESCRIPTION="Quotes from StarWars, The Empire Strikes Back, and Return of the Jedi"
HOMEPAGE="http://www.splitbrain.org/index.php?x=.%2FFortunes%2Fstarwars"
SRC_URI="http://www.splitbrain.org/Fortunes/starwars/fortune-starwars.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${PN/mod-/}

src_install() {
	insinto /usr/share/fortune
	doins starwars starwars.dat
}
