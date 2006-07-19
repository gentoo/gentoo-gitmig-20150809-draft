# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-simpsons-chalkboard/fortune-mod-simpsons-chalkboard-0.1.ebuild,v 1.11 2006/07/19 19:57:41 flameeyes Exp $

DESCRIPTION="Quotes from Bart Simpson's Chalkboard, shown at the opening of each Simpsons episode"
HOMEPAGE="http://www.splitbrain.org/index.php?x=.%2FFortunes%2Fsimpsons"
SRC_URI="http://www.splitbrain.org/Fortunes/simpsons/fortune-simpsons-chalkboard.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${PN/mod-/}

src_install() {
	insinto /usr/share/fortune
	doins chalkboard chalkboard.dat || die
}
