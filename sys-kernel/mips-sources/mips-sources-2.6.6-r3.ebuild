# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.6-r3.ebuild,v 1.2 2004/08/01 08:11:29 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040604"
COBALTPATCHVER="1.4"
IP32DIFFDATE="20040402"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 04 Jun 2004
# 3) Patch to fix the Swap issue in 2.6.5+ (Credit: Peter Horton <cobalt@colonel-panic.org>
# 4) Iluxa's minimal O2 Patchset
# 5) Security Fixes
# 6) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-26xx-${COBALTPATCHVER}.tar.bz2
		mirror://gentoo/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff.bz2"

HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-*"
IUSE=""


pkg_setup() {
	# See if we're on a cobalt system (must use the cobalt-mips profile)
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		einfo "Please keep in mind that the 2.6 kernel will NOT boot on Cobalt"
		einfo "systems that are still using the old Cobalt bootloader.  In"
		einfo "order to boot a 2.6 kernel on Cobalt systems, you must be using"
		einfo "Peter Horton's new bootloader, which does not have the kernel"
		einfo "size limitation that the older bootloader has.  If you want"
		einfo "to use the newer bootloader, make sure you have sys-boot/colo"
		einfo "installed and setup."
		echo -e ""
	fi
}

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Bug in 2.6.6 that triggers a kernel oops when swap is activated
	epatch ${FILESDIR}/mipscvs-2.6.5-swapbug-fix.patch

	# iluxa's minpatchset for SGI O2
	echo -e ""
	einfo ">>> Patching kernel with iluxa's minimal IP32 patchset ..."
	epatch ${WORKDIR}/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff

	# Security Fixes
	echo -e ""
	ebegin "Applying Security Fixes"
		epatch ${FILESDIR}/CAN-2004-0495_0496-2.6-sparse.patch.bz2
		epatch ${FILESDIR}/CAN-2004-0497-attr_gid.patch
		epatch ${FILESDIR}/CAN-2004-0596-2.6-eql.patch
		epatch ${FILESDIR}/CAN-2004-0626-death_packet.patch
	eend

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

	kernel_universal_unpack
}
