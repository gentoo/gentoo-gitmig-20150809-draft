# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-tao/fortune-mod-tao-1.ebuild,v 1.1 2003/09/10 18:14:05 vapier Exp $

MY_PN=${PN/mod-/}
DESCRIPTION="set of fortunes based on the Tao-Teh-Ching"
HOMEPAGE="http://aboleo.net/software/"
SRC_URI="http://aboleo.net/software/misc/${MY_PN}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 ~sparc ~mips"

DEPEND="app-games/fortune-mod"
RDEPEND=""

S=${WORKDIR}/${MY_PN}

src_install() {
	insinto /usr/share/fortune
	doins tao tao.dat
}
