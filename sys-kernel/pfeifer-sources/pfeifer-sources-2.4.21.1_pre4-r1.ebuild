# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pfeifer-sources/pfeifer-sources-2.4.21.1_pre4-r1.ebuild,v 1.1 2004/01/06 23:54:17 plasmaroo Exp $

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

OKV="2.4.21"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-r1_pre4"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the experimental Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${KV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha -hppa -mips -arm -amd64"
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
		einfo "Setting up kernel for EVMS 2.1.0 support."
		ewarn "Please read the 'evms2' doc provided with this kernel."
		ewarn "It is the install doc from the evms 2.1.0 tarball."
		for file in 1* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	# This is the crypt USE flag, keeps {superfreeswan/patch-int/loop-aes}
	if [ -z "`use crypt`" ]; then
		einfo "No Cryptographic support, dropping patches..."
		for file in 6* 8* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Cryptographic patches will be applied"
	fi

	# This is the usagi USE flag, keeps USAGI, drops {superfreeswan/patch-int/loop-aes}
	# Using USAGI will also cause you to drop all iptables ipv6 patches
	if [ -z "`use usagi`" ]; then
		einfo "Keeping {superfreeswan/patch-int/loop-aes} patches, dropping USAGI"
		for file in 6* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Keeping USAGI patch, dropping {superfreeswan/patch-int/loop-aes}"
		for file in *.ipv6 8* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	kernel_src_unpack
	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}-${PVR}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${PN}-${PVR}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

}

pkg_postinst() {

	kernel_pkg_postinst

	echo
	ewarn "If iptables/netfilter behaves abnormally, such as 'Invalid Argument',"
	ewarn "you will need to re-emerge iptables to restore proper functionality."
	echo
	einfo "If there are issues with it, read the docs and associated help provided."
	einfo "Next you should check http://forums.gentoo.org/ for assistance."
	einfo "Otherwise check http://bugs.gentoo.org/ for an existing bug."
	einfo "Only create a new bug if you have not found one that matches your issue."
	einfo "It is best to do an advanced search as the initial search has a very low yield."
	einfo "Assign bugs to pfeifer@gentoo.org"
	echo
	einfo "Please read the ChangeLog and associated docs for more information."
}
