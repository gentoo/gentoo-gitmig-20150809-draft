# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/xpvm/xpvm-1.2.5-r4.ebuild,v 1.1 2005/08/09 20:53:29 tantive Exp $

inherit eutils

DESCRIPTION="XPVM: A graphical console and monitor for PVM"
SRC_URI="http://www.netlib.org/pvm3/xpvm/XPVM.src.1.2.5.tgz"
HOMEPAGE="http://www.csm.ornl.gov/pvm/pvm_home.html"
IUSE=""

DEPEND=">=sys-cluster/pvm-3.4.1-r1
	dev-lang/tcl
	dev-lang/tk"
RDEPEND=""

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="LGPL-2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/xpvm-1.2.5-gentoo.diff
	epatch ${FILESDIR}/xpvm-1.2.5-secure-temp.patch
}

src_compile() {
	export XPVM_ROOT="${WORKDIR}/xpvm"

	cd ${WORKDIR}/xpvm

	if [ -z "${PVM_ROOT}" ]
	then
		die "PVM_ROOT variable not set. Please run env-update and source /etc/profile."
	elif [ -z "${PVM_ARCH}" ]
	then
		die "PVM_ARCH variable not set. Please run env-update and source /etc/profile."
	fi

	emake xpvm || die
}

src_install() {
	XPVM_ROOT=${PVM_ROOT}/xpvm

	cd ${WORKDIR}/xpvm
	dodir ${PVM_ROOT}/xpvm
	dodir ${PVM_ROOT}/bin/${PVM_ARCH}
	dodir /usr/bin

	#create symlinks to xpvm binary
	dosym ${XPVM_ROOT}/src/${PVM_ARCH}/xpvm ${PVM_ROOT}/bin/${PVM_ARCH}/xpvm
	dosym ${XPVM_ROOT}/src/${PVM_ARCH}/xpvm /usr/bin/xpvm

	#install headers and libs and binary
	cp ${WORKDIR}/xpvm ${D}/${PVM_ROOT} -r

	#environment variables:
	touch ${T}/97xpvm
	echo XPVM_ROOT=/usr/local/pvm3/xpvm/src >> ${T}/97xpvm
	insinto /etc/env.d
	doins ${T}/97xpvm

	dodoc README
}

pkg_postinst() {
	ewarn "Environment Variables have changed. Do not forget to reboot or perform"
	ewarn "source /etc/profile before using xpvm !"
}
