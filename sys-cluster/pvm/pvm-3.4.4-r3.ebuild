# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvm/pvm-3.4.4-r3.ebuild,v 1.3 2005/04/01 17:11:12 agriffis Exp $

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
KEYWORDS="~x86 ~ppc ~amd64 ~ppc64 ia64 sparc"
S="${WORKDIR}/${MY_P%%.*}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff || die
	epatch ${FILESDIR}/${P}-s390.patch || die
	epatch ${FILESDIR}/${P}-x86_64-segfault.patch || die

# setup def files for other archs
	cp conf/LINUX.def conf/LINUXI386.def
	cp conf/LINUX.m4 conf/LINUXI386.m4
	cp conf/LINUX.def conf/LINUXX86_64.def
	cp conf/LINUX.m4 conf/LINUXX86_64.m4
	cp conf/LINUX64.def conf/LINUXIA64.def
	cp conf/LINUX64.m4 conf/LINUXIA64.m4
	cp conf/LINUX64.def conf/LINUXPPC64.def
	cp conf/LINUX64.m4 conf/LINUXPPC64.m4

# s390 should go in this list if there is ever interest
# Patch the 64bit def files to look in lib64 dirs as well for libraries.
	for I in X86_64 PPC64; do
		sed -i -e "s|ARCHDLIB	=|ARCHDLIB	= -L/usr/lib64 -L/usr/X11R6/lib64|" conf/LINUX${I}.def
		sed -i -e "s|ARCHLIB	=|ARCHLIB	= -L/usr/lib64 -L/usr/X11R6/lib64|" conf/LINUX${I}.def
	done
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
	echo PVM_ARCH=$(${D}/usr/share/pvm3/lib/pvmgetarch) >> ${T}/98pvm
	insinto /etc/env.d
	doins ${T}/98pvm
}

pkg_postinst() {
	ewarn "Environment variables have changed. Do not forget to run etc-update,"
	ewarn "reboot or perform . /etc/profile before using pvm!"
}
