# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/atitvout/atitvout-0.4.ebuild,v 1.2 2002/11/12 06:56:53 vapier Exp $

DESCRIPTION="Linux ATI TV Out support program"
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/atitvout/"
SRC_URI="http://www.stud.uni-hamburg.de/users/lennart/projects/atitvout/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	dev-libs/lrmi"

S=${WORKDIR}/${PN}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin atitvout
	dodoc HARDWARE README
}
