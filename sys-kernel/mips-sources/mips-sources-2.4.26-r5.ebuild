# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.26-r5.ebuild,v 1.1 2004/08/01 08:11:29 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040712"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
COBALTPATCHVER="1.4"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}
IUSE=""

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 12 Jul 2004
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) patch to fix the mips64 Makefile to allow building of mips64 kernels
# 5) iso9660 fix
# 6) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-24xx-${COBALTPATCHVER}.tar.bz2"
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
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Security Fixes
	echo -e ""
	ebegin "Applying Security Fixes"
		epatch ${FILESDIR}/CAN-2004-0394-panic.patch
		epatch ${FILESDIR}/CAN-2004-0495-2.4-sparse.patch.bz2
		epatch ${FILESDIR}/CAN-2004-0497-attr_gid.patch
		epatch ${FILESDIR}/CAN-2004-0535-2.4-e1000.patch
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
