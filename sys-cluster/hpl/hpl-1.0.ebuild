# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/hpl/hpl-1.0.ebuild,v 1.2 2004/03/26 17:32:48 tantive Exp $

DESCRIPTION="HPL - A Portable Implementation of the High-Performance Linpack Benchmark for Distributed-Memory Computers"
HOMEPAGE="http://www.netlib.org/benchmark/hpl/"
SRC_URI="http://www.netlib.org/benchmark/hpl/hpl.tgz"
LICENSE="HPL"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-cluster/mpich
	app-sci/blas
	dev-libs/atlas"

src_compile() {
	cd ${WORKDIR}/hpl
	cp setup/Make.Linux_PII_CBLAS Make.gentoo_hpl_cblas_x86
	epatch ${FILESDIR}/Make.gentoo_hpl_cblas_x86.diff.bz2
	HOME=${WORKDIR} make arch=gentoo_hpl_cblas_x86
}

src_install() {
	cd ${WORKDIR}/hpl
	doman man/man3/*.3
	dodoc INSTALL BUGS COPYRIGHT HISTORY README TUNING
	dobin bin/gentoo_hpl_cblas_x86/xhpl
	dohtml -r www/*
	dolib lib/gentoo_hpl_cblas_x86/libhpl.a

}

pkg_postinstall() {
	einfo
	einfo "Run linpack by executing"
	einfo "\"mpirun -np 4 xhpl\""
	einfo "where -np specifies the number of processes."
}
