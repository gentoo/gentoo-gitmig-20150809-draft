# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpiexec/mpiexec-0.74.ebuild,v 1.1 2003/10/17 22:43:04 tantive Exp $

S=${WORKDIR}/mpiexec-${PV}
DESCRIPTION="Mpiexec is a replacement program for the script mpirun, 
which is part of the mpich package.  It bridges the gap between mpich 
and PBS.  It is used to initialize a parallel job from within a PBS 
batch or interactive environment."
SRC_URI="http://www.osc.edu/~pw/mpiexec/mpiexec-0.74.tgz"
HOMEPAGE="http://www.osc.edu/~pw/mpiexec/"
IUSE=""

DEPEND="virtual/glibc
		sys-cluster/openpbs
		sys-cluster/mpich"
RDEPEND="net-misc/openssh"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

# Do we have a SMP enabled kernel?
if [ ! -z "`uname -v | grep SMP`" ]
then
	export SMP=1
else
	export SMP=0
fi

src_compile() {
	cd ${S}

	#for SMP machines, disable the use of mpich/p4 shared memory
	if [ "${SMP}" = 1 ]; then
		myconf="--disable-p4-shmem"
	fi

	# mpich-p4 is the best default
	./configure --mandir=/usr/share/man \
		--prefix=/usr \
		--with-pbs=/usr \
		--with-default-comm=mpich-p4 \
		${myconf} || die
	make || die
}

src_install() {
	dodir /usr/sbin
	dodir /usr/local/bin
	
	make install prefix=${D}/usr mandir=${D}/usr/share/man 
infodir=/usr/share/infoinstall || die

	dodoc LICENSE README
}
