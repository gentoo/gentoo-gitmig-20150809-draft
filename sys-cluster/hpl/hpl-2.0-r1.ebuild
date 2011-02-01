# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/hpl/hpl-2.0-r1.ebuild,v 1.1 2011/02/01 18:27:08 jsbronder Exp $

inherit eutils

DESCRIPTION="A Portable Implementation of the High-Performance Linpack Benchmark for Distributed-Memory Computers"
HOMEPAGE="http://www.netlib.org/benchmark/hpl/"
SRC_URI="http://www.netlib.org/benchmark/hpl/hpl-${PV}.tar.gz"
LICENSE="HPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="doc"
DEPEND="virtual/mpi
	virtual/blas
	virtual/lapack"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp setup/Make.Linux_PII_FBLAS Make.gentoo_hpl_fblas_x86
	sed -i \
		-e "/^TOPdir/s,= .*,= ${S}," \
		-e '/^HPL_OPTS\>/s,=,= -DHPL_DETAILED_TIMING -DHPL_COPY_L,' \
		-e '/^ARCH\>/s,= .*,= gentoo_hpl_fblas_x86,' \
		-e '/^MPdir\>/s,= .*,=,' \
		-e '/^MPlib\>/s,= .*,=,' \
		-e "/^LAlib\>/s,= .*,= /usr/$(get_libdir)/libblas.so /usr/$(get_libdir)/liblapack.so," \
		-e '/^LINKER\>/s,= .*,= mpicc,' \
		-e '/^CC\>/s,= .*,= mpicc,' \
		-e "/^LINKFLAGS\>/s|= .*|= ${LDFLAGS}|" \
		Make.gentoo_hpl_fblas_x86
}

src_compile() {
	# parallel make failure — bug #321539
	HOME=${WORKDIR} emake -j1 arch=gentoo_hpl_fblas_x86 || die "Failed to build"
}

src_install() {
	dobin bin/gentoo_hpl_fblas_x86/xhpl || die
	dolib lib/gentoo_hpl_fblas_x86/libhpl.a || die
	dodoc INSTALL BUGS COPYRIGHT HISTORY README TUNING \
		bin/gentoo_hpl_fblas_x86/HPL.dat || die
	doman man/man3/*.3 || die
	if use doc; then
		dohtml -r www/* || die
	fi
}

pkg_postinst() {
	einfo "Remember to copy /usr/share/hpl/HPL.dat to your working directory"
	einfo "before running xhpl.  Typically one may run hpl by executing:"
	einfo "\"mpiexec -np 4 /usr/bin/xhpl\""
	einfo "where -np specifies the number of processes."
}
