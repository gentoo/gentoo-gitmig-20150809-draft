# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/atitvout/atitvout-0.4.ebuild,v 1.1 2002/12/05 11:17:42 hanno Exp $

DESCRIPTION="Linux ATI TV Out support program"
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/atitvout/"
SRC_URI="http://www.stud.uni-hamburg.de/users/lennart/projects/atitvout/${P}.tar.gz"
IUSE=""
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	sys-libs/lrmi"

S=${WORKDIR}/${PN}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin atitvout
	dodoc HARDWARE README
}
