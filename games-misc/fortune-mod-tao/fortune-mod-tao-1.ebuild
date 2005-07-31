# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-tao/fortune-mod-tao-1.ebuild,v 1.9 2005/07/31 14:41:14 corsair Exp $

MY_PN=${PN/mod-/}
DESCRIPTION="set of fortunes based on the Tao-Teh-Ching"
HOMEPAGE="http://aboleo.net/software/"
SRC_URI="http://aboleo.net/software/misc/${MY_PN}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_PN}

src_install() {
	insinto /usr/share/fortune
	doins tao tao.dat
}
