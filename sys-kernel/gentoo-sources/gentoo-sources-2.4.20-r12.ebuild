# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.20-r12.ebuild,v 1.1 2004/02/16 16:11:59 plasmaroo Exp $

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

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-sources/patches-${KV/12/11}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64"
SLOT="${KV}"


src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die "Error moving kernel source tree to linux-${KV}"

	cd ${WORKDIR}/${KV/12/11}

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

	# If the compiler isn't gcc>3.1 drop the gcc>=3.1 patches
	if [[ "${COMPILER}" == "gcc3" ]]; then
		einfo "Enabling gcc > 3.1 processor optimizations..."
		einfo "To use them, choose the processor families labelled with (gcc>31)"
		einfo "in \"Processor type and features -> Processor Family\""
	else
		einfo "Your compiler is not gcc3, dropping patches..."
		for file in *gcc3*;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	# This is the *ratified* evms2 USE flag, enables evms2 support
	if [ -z "`use evms2`" ]; then
		einfo "Setting up kernel for EVMS 1.2.1 support (default)..."
		for file in 2* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Setting up kernel for EVMS 2.0.1 support..."
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
		einfo "Cryptographic patches will be applied."
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

	kernel_exclude
	./addpatches . ${WORKDIR}/linux-${KV} || die "Could not add patches!"
	kernel_universal_unpack || die "Could not unpack!"

	epatch ${FILESDIR}/security.patch1
	epatch ${FILESDIR}/security.patch2
	epatch ${FILESDIR}/security.patch3
	epatch ${FILESDIR}/security.patch4

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to apply do_brk() fix!"
	epatch ${FILESDIR}/gentoo-sources-2.4.CAN-2003-0985.patch || die "Failed to apply mremap() fix!"
	epatch ${FILESDIR}/gentoo-sources-2.4.CAN-2004-0001.patch || die "Failed to apply AMD64 ptrace patch!"
	epatch ${FILESDIR}/gentoo-sources-2.4.20-rtc_fix.patch || die "Failed to apply RTC fix!"

}

pkg_postinst() {

	kernel_pkg_postinst

	echo
	ewarn "There is no xfs support in this kernel."
	ewarn "If you need xfs support, emerge xfs-sources."
	echo
	ewarn "If iptables/netfilter behaves abnormally, such as 'Invalid Argument',"
	ewarn "you will need to re-emerge iptables to restore proper functionality."
	echo
	einfo "This set contains the ptrace patch as part of grsecurity."
	echo
	einfo "If there are issues with it, read the docs and associated help provided."
	einfo "Next you should check http://forums.gentoo.org/ for assistance."
	echo
	einfo "Otherwise check http://bugs.gentoo.org/ for an existing bug."
	einfo "Only create a new bug if you have not found one that matches your issue."
	einfo "It is best to do an advanced search to increase search yield."
	echo
	einfo "Please assign bugs to x86-kernel@gentoo.org"
	echo
	einfo "Please read the ChangeLog and associated docs for more information."
	echo

}
