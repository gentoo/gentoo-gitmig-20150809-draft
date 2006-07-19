# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-starwars/fortune-mod-starwars-0.1.ebuild,v 1.11 2006/07/19 20:00:21 flameeyes Exp $

DESCRIPTION="Quotes from StarWars, The Empire Strikes Back, and Return of the Jedi"
HOMEPAGE="http://www.splitbrain.org/index.php?x=.%2FFortunes%2Fstarwars"
SRC_URI="http://www.splitbrain.org/Fortunes/starwars/fortune-starwars.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${PN/mod-/}

src_install() {
	insinto /usr/share/fortune
	doins starwars starwars.dat || die
}
