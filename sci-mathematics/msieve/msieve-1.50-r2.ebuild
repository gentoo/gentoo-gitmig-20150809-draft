# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/msieve/msieve-1.50-r2.ebuild,v 1.1 2012/11/25 06:22:38 patrick Exp $

EAPI=4
DESCRIPTION="A C library implementing a suite of algorithms to factor large integers"
HOMEPAGE="http://sourceforge.net/projects/msieve/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/Msieve%20v${PV}/${PN}${PV/./}src.tar.gz"

inherit eutils

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="zlib +ecm mpi"

DEPEND="ecm? ( sci-mathematics/gmp-ecm )
	mpi? ( virtual/mpi )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/-march=k8//' Makefile || die 
	sed -i -e 's/CC =/#CC =/' Makefile || die
	sed -i -e 's/CFLAGS =/CFLAGS +=/' Makefile || die
}

src_compile() {
	if use ecm; then
		export "ECM=1"
	fi
	if use mpi; then
		export "MPI=1"
	fi
	if use zlib; then
		export "ZLIB=1"
	fi
	if use amd64; then
		emake x86_64 || die "Failed to build"
	fi
	if use x86; then
		emake x86 || die "Failed to build"
	fi
}

src_install() {
	mkdir -p "${D}/usr/include/msieve"
	mkdir -p "${D}/usr/lib/"
	mkdir -p "${D}/usr/share/doc/${P}/"
	cp include/* "${D}/usr/include/msieve" || die "Failed to install"
	cp libmsieve.a "${D}/usr/lib/" || die "Failed to install"
	dobin msieve || die "Failed to install"
	cp Readme* "${D}/usr/share/doc/${P}/" || die "Failed to install"
}
