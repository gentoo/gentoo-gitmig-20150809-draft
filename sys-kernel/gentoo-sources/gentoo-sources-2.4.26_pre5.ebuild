# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.26_pre5.ebuild,v 1.2 2004/03/21 15:10:10 plasmaroo Exp $

IUSE="build crypt"

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
OKV=2.4.25
EXTRAVERSION=_pre5-gentoo
KV=2.4.26_pre5-gentoo
S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://dev.gentoo.org/~livewire/${P}.patch.bz2"
KEYWORDS="~x86 -ppc -sparc"
SLOT="${KV}"
DESCRIPTION="Full sources for the Gentoo Kernel."
src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV} || die
	bzcat ${DISTDIR}/${P}.patch.bz2 | patch -p1 || die "Failed to patch kernel, please file a bug at bugs.gentoo.org"
	# Kill patches we aren't suppposed to use, don't worry about
	# failures, if they aren't there that is a good thing!
	# This is the ratified crypt USE flag, enables IPSEC and patch-int
	make mrproper || die "make mrproper failed"
	make include/linux/version.h || die "make include/linux/version.h failed"
	kernel_universal_unpack
}
