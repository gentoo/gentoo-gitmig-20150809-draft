# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/lolo-sources/lolo-sources-2.4.19.10_pre4.ebuild,v 1.1 2002/09/24 06:41:49 lostlogic Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

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
# to /usr/share/doc/lolo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for lostlogic's Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://gentoo.lostlogicx.com/patches-${KV}.tar.bz2"
KEYWORDS="x86 -ppc -sparc -sparc64"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd ${KV}
	# Kill patches we aren't suppposed to use, don't worry about 
	# failures, if they aren't there that is a good thing!

	# This is the ratified crypt USE flag, enables IPSEC and patch-int
	[ `use crypt` ] || rm 8*

	# This is the XFS filesystem from SGI, use at your own risk ;)
	[ `use xfs` ] || rm *xfs*

	# This is the latest release of ACPI from 
	# http://www.sourceforge.net/projects/acpi	
	[ `use acpi4linux` ] || rm 70*

	kernel_src_unpack
}
