# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-hitchhiker/fortune-mod-hitchhiker-0.1.ebuild,v 1.2 2003/09/10 18:39:25 vapier Exp $

MY_P=${PN/-mod/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Quotes from Hitchhikers Guide to the Galaxy"
SRC_URI="http://www.splitbrain.org/Fortunes/hitchhiker/${MY_P}.tgz"
HOMEPAGE="http://www.splitbrain.org/index.php?x=.%2FFortunes%2Fhitchhiker"

KEYWORDS="x86 ppc ~sparc ~mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins hitchhiker hitchhiker.dat
}
