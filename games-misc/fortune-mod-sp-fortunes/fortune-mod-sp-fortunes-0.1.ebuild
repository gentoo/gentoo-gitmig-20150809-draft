# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-sp-fortunes/fortune-mod-sp-fortunes-0.1.ebuild,v 1.5 2003/12/01 21:12:34 vapier Exp $

MY_P=${P/fortune-mod-sp-fortunes/SP}
MY_PN=${PN/fortune-mod-sp-fortunes/SP}
DESCRIPTION="South Park Fortunes"
HOMEPAGE="http://eol.init1.nl/pub/linux/index.php"
SRC_URI="http://eol.init1.nl/img/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_PN}

src_install() {
	insinto /usr/share/fortune
	doins SP SP.dat
}
