# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvm/pvm-3.4.4-r2.ebuild,v 1.5 2004/09/03 19:44:42 pvdabeel Exp $

inherit eutils

MY_P="${P/-}"
DESCRIPTION="PVM: Parallel Virtual Machine"
HOMEPAGE="http://www.epm.ornl.gov/pvm/pvm_home.html"
SRC_URI="ftp://ftp.netlib.org/pvm3/${MY_P}.tgz "
IUSE=""
DEPEND=""
RDEPEND="virtual/libc"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ppc"
S="${WORKDIR}/${MY_P%%.*}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	export PVM_ROOT="${S}"
	emake || die
}

src_install() {
	dodir /usr/share/man
	rm man/man1 -fr
	mv man/man3 ${D}/usr/share/man/
	prepallman

	dodoc Readme

	#installs the rest of pvm
	dodir /usr/share/pvm3
	cp -r * ${D}/usr/share/pvm3

	#environment variables:
	echo PVM_ROOT=/usr/share/pvm3 > ${T}/98pvm
	echo PVM_ARCH=LINUX >> ${T}/98pvm
	insinto /etc/env.d
	doins ${T}/98pvm
}

pkg_postinst() {
	ewarn "Environment variables have changed. Do not forget to run etc-update,"
	ewarn "reboot or perform . /etc/profile before using pvm!"
}
