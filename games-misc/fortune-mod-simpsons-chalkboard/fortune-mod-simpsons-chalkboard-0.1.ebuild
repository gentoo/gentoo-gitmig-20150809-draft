# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-simpsons-chalkboard/fortune-mod-simpsons-chalkboard-0.1.ebuild,v 1.2 2003/09/10 18:39:26 vapier Exp $

S=${WORKDIR}/${PN/mod-/}
DESCRIPTION="Quotes from Bart Simpson's Chalkboard, shown at the opening of each Simpsons episode"
SRC_URI="http://www.splitbrain.org/Fortunes/simpsons/fortune-simpsons-chalkboard.tgz"
HOMEPAGE="http://www.splitbrain.org/index.php?x=.%2FFortunes%2Fsimpsons"

SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins chalkboard chalkboard.dat
}
