# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pfeifer-sources/pfeifer-sources-2.4.20.1_pre10.ebuild,v 1.1 2003/05/05 02:22:45 pfeifer Exp $

IUSE="build crypt evms2 aavm usagi"

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
# to /usr/share/doc/pfeifer-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the experimental Gentoo Kernel. Patches from here may move into sys-kernel/gentoo-sources"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${KV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha -hppa -mips -arm"
SLOT="${KV}"


src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die "Error moving kernel source tree to linux-${KV}"

	cd ${WORKDIR}/${KV}

	# This is the *ratified* aavm USE flag, enables aavm support in this kernel
	if [ -z "`use aavm`" ]; then
		einfo "Setting up kernel for rmap support(default)."
		for file in *.aavm ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Setting up kernel for aavm support."
		for file in *.rmap ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	# If the compiler isn't gcc>3.1 drop the gcc>3.1 patches
	if [[ "${COMPILER}" == "gcc3" ]];then
		einfo "You are using gcc>3.1"
		einfo "Enabling gcc>3.1 processor optimizations."
		einfo "To use, choose the processor family labelled with (gcc>31) in"
		einfo "Processor type and features -> Processor Family"
	else
		einfo "Your compiler is not gcc3, dropping patches..."
		for file in *gcc3*;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	# This is the *ratified* evms2 USE flag, enables evms2 support
	if [ -z "`use evms2`" ]; then
		einfo "Setting up kernel for EVMS 1.2.1 support(default)."
		for file in 2* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Setting up kernel for EVMS 2.0.1 support."
		ewarn "This is very beta. Please read the 'evms2' doc provided with this kernel."
		ewarn "It is the install doc from the evms 2.0.1 tarball."
		for file in 1* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	# This is the crypt USE flag, keeps {USAGI/superfreeswan/patch-int/loop-jari}
	if [ -z "`use crypt`" ]; then
		einfo "No Cryptographic support, dropping patches..."
		for file in 6* 8* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Cryptographic patches will be applied"
	fi

	# This is the usagi USE flag, keeps USAGI, drops {superfreeswan/patch-int/loop-jari}
	# Using USAGI will also cause you to drop all iptables ipv6 patches
	if [ -z "`use usagi`" ]; then
		einfo "Keeping {superfreeswan/patch-int/loop-jari} patches, dropping USAGI"
		for file in 6* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Keeping USAGI patch, dropping {superfreeswan/patch-int/loop-jari}"
		for file in *.ipv6 8* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	kernel_src_unpack
}

pkg_postinst() {

	kernel_pkg_postinst

	ewarn "There is no xfs support in this kernel."
	ewarn "If you need xfs support, emerge xfs-sources."
	echo
	ewarn "If iptables/netfilter behaves abnormally, such as 'Invalid Argument',"
	ewarn "you will need to re-emerge iptables to restore proper functionality."
	echo
	einfo "Please be warned, you have just installed an unstable"
	einfo "patchset of the Gentoo Linux kernel sources."
	einfo "This set contains the ptrace patch as part of grsecurity."
	echo
	einfo "If there are issues with it, please report them"
	einfo "by assigning bugs on bugs.gentoo.org to"
	einfo "x86-kernel@gentoo.org"
	echo
	einfo "Please read the changelog and associated docs for more information."
}
