# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/lolo-sources/lolo-sources-2.4.20.1_rc2.ebuild,v 1.1 2003/01/02 08:43:45 lostlogic Exp $

IUSE="build crypt xfs"

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
OKV="2.4.20"
# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/lolo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for lostlogic's Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://gentoo.lostlogicx.com/patches-${KV}.tar.bz2"
KEYWORDS="x86 -ppc -sparc"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd ${KV}
	# Kill patches we aren't suppposed to use, don't worry about 
	# failures, if they aren't there that is a good thing!

	# This is the ratified crypt USE flag, enables IPSEC and patch-int
	[ `use crypt` ] || rm 8*

	# This is the non-ratified xfs USE flag, enables XFS which is not
	# patched by default because it can cause problems with JFS's
	# journals.
	[ `use xfs` ] || rm 79*

	kernel_src_unpack
}

pkg_postinst() {

	kernel_pkg_postinst

	einfo "Please be warned, you have just installed a very beta"
	einfo "patchset of the linux kernel sources."
	einfo "If there are problems with it, please report them"
	einfo "by assigning bugs on bugs.gentoo.org to"
	einfo "lostlogic@gentoo.org"
	[ `use xfs` ] && einfo "XFS patches enabled, this may cause JFS problems" || \
		einfo "XFS not enabled, is that on purpose?  JFS users beware of XFS."

}
