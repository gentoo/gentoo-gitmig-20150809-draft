# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.4.21.ebuild,v 1.1 2003/03/23 21:26:06 zwelch Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE=""
DEPEND=""

ETYPE="headers"
inherit kernel eutils

# What's in this kernel?
# INCLUDED:
#   stock 2.4.20 kernel sources
#   2.4.21-pre5 patch
#   mips patches 

DESCRIPTION="Full sources for the Gentoo MIPS/Linux kernel"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
KEYWORDS="-arm -hppa -x86 -ppc -sparc -alpha mips"

# set the kernel version now
OKV=2.4.20
EXTRAVERSION="pre5"
KV="2.4.21-${EXTRAVERSION}"
S=${WORKDIR}/linux-${KV}
SLOT="${KV}"

# testing kernel patch
EXTRA_KERNEL_PATCH="patch-${KV}"

# this is the main MIPS Kernel Patch
MIPS_KERNEL_PATCH="linux-${KV}-20030323-mips-cvs.patch"


SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 \
	http://www.kernel.org/pub/linux/kernel/v2.4/testing/${EXTRA_KERNEL_PATCH}.bz2 \
	http://cvs.gentoo.org/~dragon/${MIPS_KERNEL_PATCH}.bz2"


src_unpack() {
	# base vanilla source
	unpack "linux-${OKV}.tar.bz2" || die
	[ "${OKV}" != "${KV}" ] && \
		mv "${WORKDIR}/linux-${OKV}" "${WORKDIR}/linux-${KV}"

	# plus the testing kernel patch
	unpack "${EXTRA_KERNEL_PATCH}.bz2" || die

	# plus MIPS cvs kernel patch
	unpack "${MIPS_KERNEL_PATCH}.bz2" || die

	# do the actual patching
	cd ${S} || die
	einfo "Applying ${ARM_KERNEL_PATCH}"
	epatch "${WORKDIR}/${EXTRA_KERNEL_PATCH}" || die
	epatch "${WORKDIR}/${MIPS_KERNEL_PATCH}" || die

	kernel_universal_unpack
}

