# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.4-r6.ebuild,v 1.1 2004/08/02 06:57:17 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040311"
COBALTPATCHVER="1.4"
SECPATCHVER="1.0"
IP32DIFFDATE="20040229"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 11 Mar 2004
# 3) Patch to tweak arch/mips/Makefile to build proper kernels under binutils-2.15.x
# 4) Iluxa's minimal O2 patchset
# 5) Security Fixes
# 6) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-26xx-${COBALTPATCHVER}.tar.bz2
		mirror://gentoo/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2"

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

	# Binutils-2.14.90.0.8 and up does some magic with page alignment
	# that prevents the kernel from booting.  This patch fixes it.
	echo -e ""
	einfo ">>> Generic Patches"
	epatch ${FILESDIR}/mipscvs-2.6.x-no-page-align.patch

	# In order to use arcboot on IP32, the kernel entry address needs to be
	# set to 0x98000000, not 0xa8000000.
	epatch ${FILESDIR}/mipscvs-2.6.x-ip32-kern_entry-arcboot.patch

	# iluxa's minpatchset for SGI O2
	echo -e ""
	einfo ">>> Patching kernel with iluxa's minimal IP32 patchset ..."
	epatch ${WORKDIR}/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff

	# Security Fixes
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		epatch ${WORKDIR}/security/CAN-2004-0075-2.6-vicam_usb.patch
		epatch ${WORKDIR}/security/CAN-2004-0109-2.6-iso9660.patch
		epatch ${WORKDIR}/security/CAN-2004-0181-2.6-jfs_ext3.patch
		epatch ${WORKDIR}/security/CAN-2004-0228-cpufreq.patch
		epatch ${WORKDIR}/security/CAN-2004-0229-fb_copy_cmap.patch
		epatch ${WORKDIR}/security/CAN-2004-0427-2.6-do_fork.patch
		epatch ${WORKDIR}/security/CAN-2004-0495_0496-2.6-sparse.patch
		epatch ${WORKDIR}/security/CAN-2004-0497-attr_gid.patch
		epatch ${WORKDIR}/security/CAN-2004-0596-2.6-eql.patch
		epatch ${WORKDIR}/security/CAN-2004-0626-death_packet.patch
		epatch ${WORKDIR}/security/security-2.6-attr_check.patch
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
