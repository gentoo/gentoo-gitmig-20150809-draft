# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.8.1-r3.ebuild,v 1.1 2004/11/27 00:45:16 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040822"			# Date of diff between kernel.org and lmo CVS
COBALTPATCHVER="1.7"			# Tarball version for cobalt patches
SECPATCHVER="1.5"			# Tarball version for security patches
GENPATCHVER="1.0"			# Tarball version for generic patches
EXTRAVERSION=".$(echo ${OKV} | cut -d. -f4)-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 14 Aug 2004
# 3) IP22, IP32 fixes
# 6) Generic Fixes
# 5) Security fixes
# 6) Patches for Cobalt support


HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-*"
IUSE="cobalt"
#IUSE="cobalt ip27"

DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		cobalt? ( mirror://gentoo/cobalt-patches-26xx-${COBALTPATCHVER}.tar.bz2 )"
#		ip27? ( mirror://lmoftp/blah.tar.bz2 )						# IP27 Patches - XXX - Not Implemented

pkg_setup() {
	# See if we're on a cobalt system (must use the cobalt-mips profile)
	if use cobalt; then
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

#	# See if we're using IP27 (Origin) - XXX - Not Implemented
#	if use ip27; then
#		echo -e ""
#		einfo ""
#		echo -e ""
#	fi
}

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Generic patches we always include
	echo -e ""
	einfo ">>> Generic Patches"
		# IP22 patches
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-ip22-fixes-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-ip22-newport-fixes-backport.patch

		# IP32 Patches
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-ip32-64b_only-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.9-ip32-iluxa_minpatchset_bits.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.7-maceisa_rtc_irq-fix.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6-ip32-onion2-gbefb-fixes-old.patch

		# gcc-3.4.x fixes
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.9-gcc34x-rem_accum.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.9-gcc34x-save_static_func.patch

		# Generic
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-better_mbind-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-elim-sys_narg_table-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-ioctl32-rtc-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-statfs-fixes-backport.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6-force_mouse_detection.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6-fix-prologue-error.patch
	eend


	# Security Fixes
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		epatch ${WORKDIR}/security/CAN-2004-0814-2.6.8.1-tty_race_conditions.patch
		epatch ${WORKDIR}/security/CAN-2004-0883-2.6.8.1-smbfs_remote_overflows.patch
		epatch ${WORKDIR}/security/security-2.6-proc_race.patch
		epatch ${WORKDIR}/security/security-2.6.8.1-binfmt_elf-fixes.patch
		epatch ${WORKDIR}/security/security-2.6-remote_ddos.patch
		epatch ${WORKDIR}/security/security-2.6.8.1-mips-ptrace.patch
	eend


	# Cobalt Patches
	if use cobalt; then
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


#	# IP27 (Origin) Hacks - XXX - Not Implemented
#	if use ip27; then
#		echo -e ""
#		einfo ">>> Patching kernel for SGI Origin (IP27) support ..."
#	fi


	kernel_universal_unpack
}
