# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/redhat-sources/redhat-sources-2.4.18.24.8.0.ebuild,v 1.2 2003/09/07 07:26:01 msterret Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV=2.4.18
KV=2.4.18-24.8.0
EXTRAVERSION="-24.8.0-rhcustom"
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

RH_DISTRO_VER="8.0"

# The easiest way to grab Red Hat kernel sources is from the rpm file
# itself.  We used to generate a patch against vanilla sources trees but
# the added dependency of rpm2targz is minimal compared with having to
# generate a new diff for every minor version update.  (Also not to many
# people have 2.4.18 vanilla source tarballs floating around these days)

DEPEND="${DEPEND} app-arch/rpm2targz"

DESCRIPTION="Kernel source tree used in Red Hat distributions (not supported by Red Hat)"
SRC_URI="http://mirrors.kernel.org/redhat/redhat/linux/updates/8.0/en/os/i386/kernel-source-${KV}.i386.rpm"
HOMEPAGE="http://www.kernel.org/ http://www.redhat.com/"
KEYWORDS="~x86"
SLOT="${KV}"

src_unpack() {

	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/kernel-source-${KV}.i386.rpm
	tar xvzf kernel-source-${KV}.i386.tar.gz

	mv usr/src/linux-${KV} ${WORKDIR}

	cd ${S}

	kernel_universal_unpack
}

