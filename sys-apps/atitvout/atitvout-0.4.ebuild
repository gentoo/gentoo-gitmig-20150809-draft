# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/atitvout/atitvout-0.4.ebuild,v 1.1 2002/11/07 16:52:56 hanno Exp $

DESCRIPTION="Linux ATI TV Out support program."
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/atitvout/"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
DEPEND="virtual/glibc
	dev-libs/lrmi"
RDEPEND=${DEPEND}
SRC_URI="http://www.stud.uni-hamburg.de/users/lennart/projects/atitvout/${P}.tar.gz"
S=${WORKDIR}/${PN}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin atitvout
	dodoc HARDWARE README
}
