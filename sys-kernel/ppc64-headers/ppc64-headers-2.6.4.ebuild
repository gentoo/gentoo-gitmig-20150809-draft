# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc64-headers/ppc64-headers-2.6.4.ebuild,v 1.1 2004/03/31 04:02:16 tgall Exp $

IUSE="build crypt"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="evms" would not patch any patches whose names match
# *evms*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

ETYPE="headers"

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}"
OKV="2.6.4"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2 
         mirror://kernel/ppc64-ames264.patch.gz"
	
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
PROVIDE="virtual/kernel virtual/os-headers"
LICENSE="GPL-2"
KEYWORDS="-x86 -ppc -sparc -alpha -hppa -mips -arm ppc64"
SLOT="${KV}"


src_unpack() {
	unpack ${A}
#	mv linux linux-${KV} || die "Error moving kernel source tree to 
# linux-${KV}"

	cd ${WORKDIR}/linux-2.6.4

	kernel_universal_unpack
	cd ${WORKDIR}/linux-2.6.4
	epatch ${WORKDIR}/ppc64-ames264.patch
}

src_install() {
        if [ "`KV_to_int ${OKV}`" -ge "`KV_to_int 2.6.0`" ]; then
                ln -sf ${S}/include/asm-${ARCH} ${S}/include/asm
        fi


        # Do normal src_install stuff
        kernel_src_install

        # If this is 2.5 or 2.6 headers, then we need asm-generic too
        if [ "`KV_to_int ${OKV}`" -ge "`KV_to_int 2.6.0`" ]; then
                dodir /usr/include/asm-generic
                cp -ax ${S}/include/asm-generic/* ${D}/usr/include/asm-generic
        fi

}

pkg_preinst() {
	kernel_pkg_preinst
}

pkg_postinst() {

	kernel_pkg_postinst

	ewarn "There is no xfs support in this kernel."
	echo
	ewarn "If iptables/netfilter behaves abnormally, such as 'Invalid Argument',"
	ewarn "you will need to re-emerge iptables to restore proper functionality."
}
