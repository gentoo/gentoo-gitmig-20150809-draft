# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.22-r2.ebuild,v 1.1 2004/01/05 18:28:54 scox Exp $

IUSE="build selinux"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.22
EXTRAVERSION=-hardened
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}
DESCRIPTION="Special Security Hardened Gentoo Linux Kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/patches-${KV}.tar.bz2"


HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/proj/en/hardened/"
KEYWORDS="~x86 ~ppc"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2 patches-${KV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd ${KV}
	# We can't use LSM/SELinux and GRSec in the same kernel.  If USE=selinux, we will
	# patch in LSM/SELinux and drop support for GRsec.  Otherwise we will include GRSec.
	if [ "`use selinux`" ]; then
		einfo "Enabling SELinux support.  This will drop GRSec2 support."
		for file in *grsec*; do
			einfo "Dropping ${file}.."
			rm -f ${file}
		done
	else
		einfo "Did not find \"selinux\" in use, building with GRSec2 support."
		for file in *lsm* *selinux*; do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	kernel_src_unpack

	cd ${S}
	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"
	epatch ${FILESDIR}/mremap-CAN-2003-0985.patch || die "failed to patch for mremap vuln"
}

pkg_postinst() {
	einfo "This kernel contains LSM/SElinux or GRSecurity, and Systrace"
	einfo "Also included are various other performance and security related patches"
	einfo "If you experience problems with this kernel please report them by"
	einfo "assigning bugs on bugs.gentoo.org to frogger@gentoo.org"
	if [ "`use selinux`" ]; then
		einfo ""
		einfo "Warning!  This kernel contains the new SELinux API and currently"
		einfo "does not support ReiserFS.  If you need ReiserFS support, and are"
		einfo "using SELinux, then do not use this kernel."
		einfo ""
		einfo "The new SELinux API contains many changes from the previous API,"
		einfo "including new userspace utilities.  Please see "
		einfo "http://www.gentoo.org/proj/en/hardened/selinux for more info."
	fi
}

