# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.25-r6.ebuild,v 1.1 2004/08/02 06:57:17 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040222"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
COBALTPATCHVER="1.4"
SECPATCHVER="1.0"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}
IUSE=""

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 22 Feb 2004
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) patch to fix the mips64 Makefile to allow building of mips64 kernels
# 5) Security Fixes
# 6) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-24xx-${COBALTPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* mips"


src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	echo -e ""
	einfo ">>> Generic Patches"
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Patch to fix mips64 Makefile so that -finline-limit=10000 gets added to CFLAGS
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-inlinelimit.patch

	# Binutils-2.14.90.0.8 and does some magic with page alignment
	# that prevents the kernel from booting.  This patch fixes it.
	epatch ${FILESDIR}/mipscvs-${OKV}-no-page-align.patch

	# Security Fixes
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		epatch ${WORKDIR}/security/CAN-2004-0109-2.4-iso9660.patch
		epatch ${WORKDIR}/security/CAN-2004-0133-xfs_ext3.patch
		epatch ${WORKDIR}/security/CAN-2004-0177-ext3_jbd.patch
		epatch ${WORKDIR}/security/CAN-2004-0178-sbblaster.patch
		epatch ${WORKDIR}/security/CAN-2004-0181-2.4-jfs_ext3.patch
		epatch ${WORKDIR}/security/CAN-2004-0394-panic.patch
		epatch ${WORKDIR}/security/CAN-2004-0427-2.4-do_fork.patch
		epatch ${WORKDIR}/security/CAN-2004-0495-2.4-sparse.patch
		epatch ${WORKDIR}/security/CAN-2004-0497-attr_gid.patch
		epatch ${WORKDIR}/security/CAN-2004-0535-2.4-e1000.patch
	eend

	# Cobalt Patches
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
		cp ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/cobalt-patches.txt ${S}
		cd ${WORKDIR}
		mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.cobalt
		S="${S}.cobalt"
	fi

	kernel_universal_unpack
}
