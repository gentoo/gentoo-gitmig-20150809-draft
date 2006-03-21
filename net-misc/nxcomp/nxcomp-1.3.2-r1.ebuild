# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxcomp/nxcomp-1.3.2-r1.ebuild,v 1.4 2006/03/21 18:42:28 agriffis Exp $

MY_P="${PN}-1.3.2-4"
DESCRIPTION="X11 protocol compression library"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="http://www.nomachine.com/download/nxsources/nxcomp/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
RDEPEND=">=media-libs/jpeg-6b-r3
	>=media-libs/libpng-1.2.5-r4
	>=sys-libs/glibc-2.3.2-r3
	>=sys-libs/zlib-1.1.4-r2
	|| ( x11-libs/libXt virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2.3-r2
	|| ( x11-proto/xproto virtual/x11 )"

S=${WORKDIR}/${PN}

src_compile() {
	./configure
	DISTCC_HOSTS="localhost" CCACHE_DISABLE="1" emake || die "compile problem"
}

src_install() {
	into /usr/NX
	dolib libXcomp.so.${PV}
	into /usr
	preplib /usr/NX

	dodoc README README-IPAQ LICENSE VERSION

	insinto /usr/NX/include
	doins NX.h
}
