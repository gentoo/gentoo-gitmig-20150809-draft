# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ia64-sources/ia64-sources-2.4.24.ebuild,v 1.1 2004/01/29 23:15:52 agriffis Exp $

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

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

#MYCSET="1.1063.2.37-to-1.1088"
MYSNAPSHOT="040109"
DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
mirror://kernel/linux/kernel/ports/ia64/v2.4/linux-${OKV}-ia64-${MYSNAPSHOT}.diff.bz2"

HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="-* ~ia64"
SLOT="${KV}"

src_unpack() {

	unpack linux-${OKV}.tar.bz2
	cd ${WORKDIR}
	mv linux-${OKV} linux-${KV} || die "Error moving kernel source tree to linux-${KV}"
	cd ${WORKDIR}/linux-${KV}
#	[ ! -e ${DISTDIR}/cset-${MYCSET}.txt.gz ] && die "patch file not found"
#	cat ${DISTDIR}/cset-${MYCSET}.txt.gz | gzip -d | patch -f -p1
	[ ! -e ${DISTDIR}/linux-${OKV}-ia64-${MYSNAPSHOT}.diff.bz2 ] && die "patch not found"
	cat ${DISTDIR}/linux-${OKV}-ia64-${MYSNAPSHOT}.diff.bz2 | bzip2 -d | patch -f -p1

	# 2.4.24 includes the do_brk, mremap and rtc fixes, so those
	# patches aren't needed (29 Jan 2004 agriffis)

	kernel_universal_unpack
}

pkg_postinst() {
	kernel_pkg_postinst
}
