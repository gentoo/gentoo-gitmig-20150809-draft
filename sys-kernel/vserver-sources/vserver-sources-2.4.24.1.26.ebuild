# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-2.4.24.1.26.ebuild,v 1.1 2004/03/25 13:41:30 tantive Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV=2.4.24
KV=2.4.24

## idea: after the kernel-version (2.4.23) we append the vs-version (e.g. 1.22) to
## get 2.4.23.1.22 that is globbed out here:
EXTRAVERSION="-vs${PV#*.*.*.}"

S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
# stock 2.4.23 kernel sources (or newer)
# vs-1.20 (or newer)

DESCRIPTION="Linux kernel with ctx-/vserver-patch"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://www.13thfloor.at/vserver/s_release/${EXTRAVERSION/-vs/v}/patch-${KV}${EXTRAVERSION}.diff.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.13thfloor.at/vserver/ http://www.linux-vserver.org/"

KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	cd ${WORKDIR}
	mv linux-${OKV} linux-${KV}${EXTRAVERSION} || die "mv to -extraversion failed"

	cd linux-${KV}${EXTRAVERSION} || die "cd to kernel-src failed"
	epatch ${DISTDIR}/patch-${KV}${EXTRAVERSION}.diff.bz2
	#zcat ${DISTDIR}/patch-${KV}${EXTRAVERSION}.gz |\
	#	patch -p1 || die "patching kernel with vserver failed"

	kernel_universal_unpack
}
