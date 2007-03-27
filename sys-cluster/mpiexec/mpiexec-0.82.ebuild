# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpiexec/mpiexec-0.82.ebuild,v 1.2 2007/03/27 18:53:57 opfer Exp $

inherit eutils flag-o-matic

DESCRIPTION="replacement for mpirun, integrates MPI with PBS."
SRC_URI="http://www.osc.edu/~pw/mpiexec/${P}.tgz"
HOMEPAGE="http://www.osc.edu/~pw/mpiexec/"
IUSE="sharedmem"

DEPEND="virtual/libc
		virtual/pbs
		virtual/mpi"
RDEPEND="net-misc/openssh"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"

src_compile() {
	# sharedmem should NOT be used on SMP boxes
	myconf="`use_enable sharedmem p4-shmem`"

	# mpich-p4 is the best default
	append-ldflags -L/usr/$(get_libdir)/pbs/lib
	./configure --mandir=/usr/share/man/man1/ \
		--prefix=/usr \
		--with-pbs=/usr \
		--with-default-comm=mpich-p4 \
		${myconf} || die "configure failed"

	make || die "compile failed"

	## demo-hello: usefull for debugging
	make hello || die "compile hello failed"
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1/ \
		install || die "install failed"

	## demo-hello:
	dodoc hello.c
	newbin hello hello_mpiexec

	dodoc LICENSE README README.lam ChangeLog
}
