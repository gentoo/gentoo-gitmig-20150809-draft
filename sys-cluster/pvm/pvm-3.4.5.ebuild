# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvm/pvm-3.4.5.ebuild,v 1.7 2005/08/23 20:30:35 agriffis Exp $

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
KEYWORDS="~amd64 ia64 ppc ~ppc64 ~sparc x86"
S="${WORKDIR}/${MY_P%%.*}"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patches from Red Hat
	epatch ${FILESDIR}/${P}-envvars.patch || die
	epatch ${FILESDIR}/${P}-strerror.patch || die
	epatch ${FILESDIR}/${P}-extra-arches.patch || die
	epatch ${FILESDIR}/${P}-x86_64-segfault.patch || die

# setup def files for other archs
	cp conf/LINUX64.def conf/LINUXPPC64.def
	cp conf/LINUX64.m4 conf/LINUXPPC64.m4

# s390 should go in this list if there is ever interest
# Patch the 64bit def files to look in lib64 dirs as well for libraries.
	for I in 64 PPC64; do
		sed -i -e "s|ARCHDLIB	=|ARCHDLIB	= -L/usr/lib64 -L/usr/X11R6/lib64 |" conf/LINUX${I}.def || die "Failed to fix 64-bit"
		sed -i -e "s|ARCHLIB	=|ARCHLIB	= -L/usr/lib64 -L/usr/X11R6/lib64 |" conf/LINUX${I}.def || die "Failed to fix 64-bit"
	done

}

src_compile() {
	unset PVM_ARCH

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
	doenvd ${T}/98pvm
}

pkg_postinst() {
	ewarn "Environment variables have changed. Do not forget to run etc-update,"
	ewarn "reboot or perform . /etc/profile before using pvm!"
}
