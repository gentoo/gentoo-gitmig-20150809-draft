# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sparc-sources/sparc-sources-2.4.21.ebuild,v 1.1 2003/06/16 00:36:33 joker Exp $

IUSE="build ultra1"

# OKV=original kernel version, KV=patched kernel version.  They can be the
# same.
KV=${PV}

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="evms" would not patch any patches whose names match
# *evms*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

# This kernel also has support for the local USE flag acpi4linux which
# activates the latest code from acpi.sourceforge.net instead of the
# very out of date vanilla version

ETYPE="sources"

inherit kernel || die

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/sparc-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${PVR}-sparc.tar.bz2"
KEYWORDS="-*"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd ${KV}
	# Kill patches we aren't suppposed to use, don't worry about 
	# failures, if they aren't there that is a good thing!

	kernel_src_unpack

	# Patch the HME driver only on Ultra1 machines.
	use ultra1 && epatch ${FILESDIR}/U1-hme-lockup.patch
}

pkg_postinst() {
	kernel_pkg_postinst

	# Display SUN Ultra 1 HME warning if it can be detected or if the machinetype is unknown.
	if [ ! -r "/proc/openprom/name" -o "`cat /proc/openprom/name 2>/dev/null`" = "'SUNW,Ultra-1'" ]; then
		einfo
		einfo "For users with an Enterprise model Ultra 1 using the HME network interface,"
		einfo "please emerge the kernel using the following command:"
		einfo
		einfo "USE=ultra1 emerge sparc-sources"
		einfo
	fi
}
