# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-test-sources/gentoo-test-sources-2.4.22.ebuild,v 1.4 2003/11/23 15:50:38 iggy Exp $

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

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-gentest"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/gentoo-test-sources-${PV}.patch.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha -hppa -mips -arm ~amd64 ~ia64"
SLOT="${KV}"


src_unpack() {
	unpack ${A}

	mv linux-${OKV} linux-${KV} || die "Error moving kernel source tree to linux-${KV}"

	cd linux-${KV}

	bzcat ${DISTDIR}/gentoo-test-sources-${PV}.patch.bz2 | patch -p1 || die "Failed to patch kernel, please file a bug at bugs.gentoo.org"

	kernel_src_unpack
}

pkg_postinst() {

	kernel_pkg_postinst

	einfo "If there are issues with this kernel, http://bugs.gentoo.org/ for an existing bug."
	einfo "Only create a new bug if you have not found one that matches your issue."
	einfo "It is best to do an advanced search as the initial search has a very low yield."
	einfo "Assign bugs to x86-kernel@gentoo.org"
	echo
	einfo "Please read the changelog and associated docs for more information."
}
