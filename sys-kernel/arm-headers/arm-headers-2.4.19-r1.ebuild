# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/arm-headers/arm-headers-2.4.19-r1.ebuild,v 1.5 2004/02/06 18:18:27 iggy Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE=""
DEPEND=""
LICENSE="GPL-2"

ETYPE="headers"
inherit kernel eutils

#####
# move to arm profile

# the current target platform
ARCH_PROFILE=netwinder

#####

# this specifies the main ARM kernel patch level
ARM_PATCH_SUFFIX="-rmk7"

######

# this specifies the SUBARCH kernel patch level and download location
#  currently, only netwinder supported
SUBARCH_KERNEL_SUFFIX="-nw1"
#SUBARCH_KERNEL_URLBASE="\
#	http://netwinder.oregonstate.edu/users/r/ralphs/kernel/beta"
SUBARCH_KERNEL_URLBASE="\
	ftp://ftp.netwinder.org/users/r/ralphs/kernel/beta"
SUBARCH_KERNEL_HOMEPAGE="http://www.netwinder.org/"

#####

# set the kernel version now
OKV=2.4.19
EXTRAVERSION="${ARM_PATCH_SUFFIX}${SUBARCH_KERNEL_SUFFIX}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# this is the main rmk ARM Kernel Patch
ARM_KERNEL_PATCH="patch-${OKV}${ARM_PATCH_SUFFIX}"
# this is the kernel patch for SUBARCH
[ -n "${SUBARCH_KERNEL_SUFFIX}" ] && \
	SUBARCH_KERNEL_PATCH="${ARM_KERNEL_PATCH}${SUBARCH_KERNEL_SUFFIX}" || \
	SUBARCH_KERNEL_PATCH=""

# What's in this kernel?
# INCLUDED:
#   stock 2.4.19 kernel sources
#   rmk patches for armlinux support

DESCRIPTION="Full sources for the ARM/Linux kernel"
KEYWORDS="arm -hppa -x86 -ppc -sparc -alpha -mips"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 \
	ftp://ftp.arm.linux.org.uk/pub/armlinux/source/kernel-patches/v2.4/${ARM_KERNEL_PATCH}.bz2"
HOMEPAGE="http://www.arm.linux.org.uk/ \
		http://www.kernel.org/ \
		http://www.gentoo.org/"
SLOT="0"

# now fix up SRC_URI and HOMEPAGE
if [ -n "${SUBARCH_KERNEL_PATCH}" ]; then
	if [ -n "${SUBARCH_KERNEL_URLBASE}" ]; then
		SRC_URI="${SRC_URI} \
			${SUBARCH_KERNEL_URLBASE}/${SUBARCH_KERNEL_PATCH}.gz"
	else
		die "${SUBARCH}: ${SUBARCH_KERNEL_PATCH} does not have a URLBASE"
	fi
fi
if [ -n "${SUBARCH_KERNEL_HOMEPAGE}" ]; then
	HOMEPAGE="${SUBARCH_KERNEL_HOMEPAGE} ${HOMEPAGE}"
fi

src_unpack() {
	# base vanilla source
	unpack "linux-${OKV}.tar.bz2" || die
	[ "${OKV}" != "${KV}" ] && \
		mv "${WORKDIR}/linux-${OKV}" "${WORKDIR}/linux-${KV}"

	# plus the Russell M. King kernel patches
	unpack "${ARM_KERNEL_PATCH}.bz2" || die

	# plus an optional SUBARCH kernel patch
	[ -n "${SUBARCH_KERNEL_PATCH}" ] && \
		{ unpack "${SUBARCH_KERNEL_PATCH}.gz" || die; }

	# do the actual patching
	cd ${S} || die
	epatch "${WORKDIR}/${ARM_KERNEL_PATCH}" || die
	[ -n "${SUBARCH_KERNEL_PATCH}" ] && \
		{ epatch "${WORKDIR}/${SUBARCH_KERNEL_PATCH}" || die; }

	sed -i -e "s,^ARCH .*$,ARCH = arm," Makefile

	kernel_universal_unpack
}

src_compile() {
	# before doing the typical make oldconfig,
	#  load the specific platform configuration
	make ${ARCH_PROFILE}_config || die

	yes "" 2>/dev/null | make oldconfig
	make archdep
}

