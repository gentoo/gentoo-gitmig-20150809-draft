# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.3-r2.ebuild,v 1.1 2004/03/08 09:15:50 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040305"
COBALTPATCHVER="1.1"
IP32DIFFDATE="20040229"
[ "${USE_IP32}" = "yes" ] && EXTRAVERSION="-mipscvs-${CVSDATE}-ip32" || EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"




# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 18 Feb 2004
# 3) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-26xx-${COBALTPATCHVER}.tar.bz2
		mirror://gentoo/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff.bz2"

HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* ~mips"


pkg_setup() {
	# See if we're on a cobalt system (must use the cobalt-mips profile)
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		ewarn "Please keep in mind that the 2.6 kernel will NOT boot on Cobalt"
		ewarn "systems that are still using the old Cobalt bootloader.  In"
		ewarn "order to boot a 2.6 kernel on Cobalt systems, you must be using"
		ewarn "Peter Horton's new bootloader, which does not have the kernel"
		ewarn "size limitation that the older bootloader has.  As of this"
		ewarn "ebuild revision, this bootloader is not in portage, and 2.6"
		ewarn "support on cobalt should be regarded as HIGHLY experimental."
		echo -e ""
	fi

	# See if we're building IP32 sources
	if [ "${USE_IP32}" = "yes" ]; then
		echo -e ""
		ewarn "SGI O2 (IP32) support is still a work in progress, and may or may"
		ewarn "not work properly.  Any bugs encountered running these sources on"
		ewarn "an O2 should be reported to the gentoo-mips mailing list.  Patches"
		ewarn "any bugs are also welcome."
		echo -e ""
	fi
}

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Cobalt Patches
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-26xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
		cp ${WORKDIR}/cobalt-patches-26xx-${COBALTPATCHVER}/cobalt-patches.txt ${S}
		cd ${WORKDIR}
		mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.cobalt
		S="${S}.cobalt"
	fi

	# IP32 Support
	# The USE_IP32 variable below must be passed on the command line to the emerge call
	if [ "${USE_IP32}" = "yes" ]; then
		echo -e ""
		einfo ">>> Patching kernel with iluxa's minimal IP32 patchset ..."
		epatch ${WORKDIR}/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff
		KV="${KV}-ip32"
		cd ${WORKDIR}
		mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.ip32
		S="${S}.ip32"
	fi
	kernel_universal_unpack
}
