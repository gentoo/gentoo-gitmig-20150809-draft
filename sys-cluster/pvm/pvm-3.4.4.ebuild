# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvm/pvm-3.4.4.ebuild,v 1.2 2002/12/15 11:58:45 bjb Exp $

S=${WORKDIR}/pvm-${PV}
DESCRIPTION="PVM: Parallel Virtual Machine"
SRC_URI="ftp.netlib.org/pvm3/pvm${PV}.tgz"
HOMEPAGE="http://www.epm.ornl.gov/pvm/pvm_home.html"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~alpha"

src_unpack() {
	unpack ${A}
}



src_compile() {
	cd ${WORKDIR}
	cd pvm3

	export PVM_ROOT=${WORKDIR}"/pvm3"
	export
	make || die
}

src_install() {
	cd ${WORKDIR}

	dodir /opt/pvm3
	cp -r * ${D}/opt

	#installs man and doc into system
	#
	#cd pvm3
	#dodir /usr/share/man/man1
	#dodir /usr/share/man/man3
	#for i in man/man1 man/man3 ; do
	#	cd ${i}
	#       mv * ${D}/usr/share/${i}
	#	cd ${WORKDIR}
	#        cd pvm3
	#    done
	#cd ${D}/usr/share/doc    
	#dodoc arches bugreport example.pvmrc release-notes
}

