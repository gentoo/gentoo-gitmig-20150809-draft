# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE=""

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

KV=2.4.19-selinux
EXTRAVERSION=selinux
S=${WORKDIR}/linux-${KV}
OKV=2.4.19
DESCRIPTION="LSM patched kernel with SELinux archive"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 
	mirror://gentoo/patches-${KV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.nsa.gov/selinux"
KEYWORDS="~x86 -ppc -sparc "
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd ${KV}
	kernel_src_unpack
}
