# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

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
	cd ${WORKDIR}
	patch -p0 <${FILESDIR}/pvm-3.4.4-gentoo.diff || die
}



src_compile() {
	cd ${WORKDIR}/pvm3

	export PVM_ROOT=${WORKDIR}"/pvm3"

	emake || die
}

src_install() {
	cd ${WORKDIR}/pvm3

	dodir /usr/share/man
	rm man/man1 -fr
	mv man/man3 ${D}/usr/share/man/
	prepallman

	dodoc Readme

	#installs the rest of pvm

	dodir /usr/local/pvm3
	cp -r * ${D}/usr/local/pvm3

	#environment variables:

	touch 98pvm
	echo PVM_ROOT=/usr/local/pvm3 >98pvm
	echo PVM_ARCH=LINUX >>98pvm
	insinto /etc/env.d
	doins 98pvm

}

pkg_postinst() {
	ewarn "Environment Variables have changed. Do not forget to reboot or perform"
	ewarn "source /etc/profile before using pvm !"
}

