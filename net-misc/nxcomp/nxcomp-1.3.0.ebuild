# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxcomp/nxcomp-1.3.0.ebuild,v 1.2 2003/12/21 16:08:19 stuart Exp $

MY_P="${PN}-1.3.0-48"
DESCRIPTION="X11 protocol compression library"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="http://www.nomachine.com/download/nxsources/nxcomp/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=""
# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	./configure
	emake || die "compile problem"
}

src_install() {
	insinto /usr/NX/lib
	dolib libXcomp.so.1.3.0

	dodoc README README-IPAQ LICENSE VERSION

	insinto /usr/NX/include
	doins NX.h
}
