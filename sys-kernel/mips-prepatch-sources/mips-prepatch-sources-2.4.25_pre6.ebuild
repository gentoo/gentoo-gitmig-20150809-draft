# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-prepatch-sources/mips-prepatch-sources-2.4.25_pre6.ebuild,v 1.1 2004/02/10 06:57:29 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040209"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
COBALTPATCHVER="1.1"
STABLEVERSION="2.4.24"

# Miscellaneous
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass Stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux stable sources from kernel.org
# 2) patch to latest linux prepatch sources
# 3) linux-mips.org CVS snapshot diff from 09 Feb 2004
# 4) patch to fix Makefile(s) to pass appropriate CFLAGS
# 5) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS pre-patch sources for MIPS-based machines"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${STABLEVERSION}.tar.bz2
		mirror://kernel/linux/kernel/v2.4/testing/patch-${OKV}.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-24xx-${COBALTPATCHVER}.tar.bz2"
HOMEPAGE="http://www.kernel.org   http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* ~mips"


src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${STABLEVERSION} ${S}
	cd ${S}

	# Update the vanilla sources with prepatch diff
	einfo ">>> Patching linux-${STABLEVERSION} to linux-${OKV} ..."
	epatch ${WORKDIR}/patch-${OKV}
	echo -e ""

	# Update the vanilla prepatch sources with linux-mips CVS changes
	einfo ">>> Patching linux-${OKV} to linux-${OKV}${EXTRAVERSION} ..."
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff
	echo -e ""

	# Patch arch/mips/Makefile & arch/mips64/Makefile
	einfo ">>> Patching Makefile(s) ..."
	epatch ${FILESDIR}/mipscvs-${OKV}-${CVSDATE}-makefile.patch
	echo -e ""

	# Cobalt stuff
#	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
		cp ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/cobalt-patches.txt ${S}
#	fi

	kernel_universal_unpack
}
