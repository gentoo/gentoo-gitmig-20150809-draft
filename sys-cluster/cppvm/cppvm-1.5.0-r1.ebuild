# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cppvm/cppvm-1.5.0-r1.ebuild,v 1.5 2004/07/15 02:53:19 agriffis Exp $

DESCRIPTION="CPPVM: A C++ Interface to PVM"
SRC_URI="ftp://ftp.informatik.uni-stuttgart.de/pub/cppvm/cppvm.tar.gz"
HOMEPAGE="http://www.informatik.uni-stuttgart.de/ipvr/bv/cppvm/index.html"
IUSE=""

DEPEND=">=sys-cluster/pvm-3.4.1-r1"
RDEPEND=""

SLOT="0"
LICENSE="LGPL-2"

KEYWORDS="x86"

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${WORKDIR}/cppvm

#	export PVM_ROOT="/usr/local/pvm3"
#	export PVM_ARCH="LINUX"

	# Doesn't build in parallel (#47556)
	emake -j1 || die
}

src_install() {
	cd ${WORKDIR}
	dodir ${PVM_ROOT}/bin/${PVM_ARCH}
	dodir ${HOME}/pvm3/bin/${PVM_ARCH}
	cd cppvm

	export PVM_ROOT=${D}/${PVM_ROOT}
	export HOME=${D}/${HOME}
#	export PVM_ARCH="LINUX"

	einstall

	#install headers and libs
	cp ${WORKDIR}/cppvm ${PVM_ROOT} -r

	dodoc CONTACT LICENCE README VERSION doc/cppvm.ps

}

pkg_postinst() {
	ewarn "Do not forget do copy the /root/pvm3 dir to the homedirs of all users"
	ewarn "that should be allowed access to cppvm!"
}
