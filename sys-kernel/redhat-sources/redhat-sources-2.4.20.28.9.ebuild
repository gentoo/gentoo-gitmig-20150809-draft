# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/redhat-sources/redhat-sources-2.4.20.28.9.ebuild,v 1.1 2004/01/07 11:08:48 plasmaroo Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel rpm
OKV=2.4.20
KV=2.4.20-28.9
EXTRAVERSION="-28.9-rhcustom"
S=${WORKDIR}/linux-${KV}

# This package contains the Linux Kernel source for the version of the
# Linux Kernel shipped by Red Hat, Inc. as part of their 8.0 distribution.
#
# Do not report problems with this source package or the resulting compiled
# compiled kernel to Red Hat, Inc.  Red Hat is not responsible for this
# package and has offered no warranties or promises that the kernels
# resulting from the compilation of this package will work on anything
# except specific versions of the Red Hat distribution and specific
# compiler revisions.
#
# Gentoo provides this package without any guarantees that this kernel
# will compile and run correctly and will only respond to bug reports
# dealing with Gentoo specific packaging problems.

# The easiest way to grab Red Hat kernel sources is from the rpm file
# itself.  We used to generate a patch against vanilla sources trees but
# the added dependency of rpm2targz is minimal compared with having to
# generate a new diff for every minor version update.

DESCRIPTION="Kernel source tree used in Red Hat distributions (not supported by Red Hat)"
SRC_URI="ftp://updates.redhat.com/9/en/os/i386/kernel-source-${KV}.i386.rpm"
HOMEPAGE="http://www.kernel.org/ http://www.redhat.com/"
KEYWORDS="~x86"
SLOT="${KV}"

src_unpack() {

	rpm_unpack ${DISTDIR}/kernel-source-${KV}.i386.rpm

	cd ${WORKDIR}
	mv usr/src/linux-${KV} ${WORKDIR}
	cd ${S}
	kernel_universal_unpack

}

