# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpiexec/mpiexec-0.76-r1.ebuild,v 1.2 2004/08/31 02:54:52 mr_bones_ Exp $

#S=${WORKDIR}/mpiexec-${PV}
DESCRIPTION="replacement for mpirun, integrates MPI with PBS."
SRC_URI="http://www.osc.edu/~pw/mpiexec/${P}.tgz"
HOMEPAGE="http://www.osc.edu/~pw/mpiexec/"
IUSE=""

DEPEND="virtual/libc
	|| (
		sys-cluster/torque
		sys-cluster/openpbs )
	sys-cluster/mpich"
RDEPEND="net-misc/openssh"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

pkg_setup() {
	# Do we have a SMP enabled kernel?
	if [ ! -z "`uname -v | grep SMP`" ]
	then
		export SMP=1
	else
		export SMP=0
	fi
}

src_compile() {
	#for SMP machines, disable the use of mpich/p4 shared memory
	if [ "${SMP}" = 1 ]; then
		myconf="--disable-p4-shmem"
	fi

	# mpich-p4 is the best default
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
	dobin hello
	mv ${D}/usr/bin/hello{,_mpiexec} || die "moving hello failed"

	dodoc LICENSE README README.lam ChangeLog
}
