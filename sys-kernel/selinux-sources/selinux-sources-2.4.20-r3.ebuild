# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="selinux"


# OKV=original kernel version, KV=patched kernel version.  They can be the same.

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="evms" would not patch any patches whose names match
# *evms*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

ETYPE="sources"

inherit kernel || die

EXTRAVERSION=selinux
S=${WORKDIR}/linux-${KV}
OKV=2.4.20
DESCRIPTION="LSM patched kernel with SELinux archive"

SEPATCH=cvs-20030328
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 
	 http://linux.pebenito.dhs.org/selinux-sources/lsm-2.4-${SEPATCH}.patch
	 http://linux.pebenito.dhs.org/selinux-sources/selinux-2.4-${SEPATCH}.patch"

HOMEPAGE="http://www.kernel.org/ http://www.nsa.gov/selinux"
KEYWORDS="~x86"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die
	
	cd linux-${KV}
	epatch ${WORKDIR}/lsm-2.4-${SEPATCH}.patch
	epatch ${WORKDIR}/selinux-2.4-${SEPATCH}.patch

	kernel_src_unpack
}

src_install() {
	insinto /usr/flask
	doins ${S}/security/selinux/flask/access_vectors
	doins ${S}/security/selinux/flask/security_classes 
	doins ${S}/security/selinux/flask/initial_sids

	insinto /usr/include/linux/flask
	doins ${S}/security/selinux/include/linux/flask/*.h
	
	insinto /usr/include/asm/flask
	doins ${S}/security/selinux/include/asm/flask/uninstd.h

	kernel_src_install
}
	
