# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.10-r1.ebuild,v 1.1 2005/01/19 02:58:24 kumba Exp $


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 09 Jan 2005
# 3) Generic Fixes
# 4) Security fixes
# 5) Patch for IP28 Indigo2 Impact Support	(http://home.alphastar.de/fuerst/download.html)
# 6) Patch for IP30 Octane Support		(http://helios.et.put.poznan.pl/~sskowron/ip30/)
# 7) Patch for Cobalt support			(http://www.colonel-panic.org/cobalt-mips/)



#//------------------------------------------------------------------------------



# Version Data
OKV=${PV/_/-}
CVSDATE="20050115"			# Date of diff between kernel.org and lmo CVS
SECPATCHVER="1.10"			# Tarball version for security patches
GENPATCHVER="1.6"			# Tarball version for generic patches
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
USERC="no"				# If set to "yes", then it will attempt to use an RC kernel

# Sources dir
S="${WORKDIR}/linux-${OKV}-${CVSDATE}"

# Eclass stuff
ETYPE="sources"
inherit kernel eutils

# Misc. stuff
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-*"
IUSE="cobalt ip28 ip30 livecd"


# If USERC == "yes", use a release candidate kernel (2.6.X-rcY)
if [ "${USERC}" = "yes" ]; then
	KVMjMn="${OKV%.*}"				# Kernel Major/Minor
	KVREV="${OKV%%-*}"				# Kernel Revision Pt. 1
	KVREV="${KVREV##*.}"				# Kernel Revision Pt. 2
	KVRC="${OKV#*-}"				# Kernel RC
	STABLEVER="${KVMjMn}.$((${KVREV} - 1))"		# Last stable Kernel version (Revision - 1)
	PATCHVER="mirror://kernel/linux/kernel/v2.6/testing/patch-${OKV}.bz2"
	EXTRAVERSION="-${KVRC}-mipscvs-${CVSDATE}"
	KV="${OKV}-${EXTRAVERSION}"
else
	STABLEVER="${OKV}"
	PATCHVER=""
fi


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${STABLEVER}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		${PATCHVER}"



#//------------------------------------------------------------------------------



# Error message 
err_only_one_arch_allowed() {
	echo -e ""
	eerror "A patchset for a specific machine-type has already been selected."
	eerror "No other patches for machines-types are permitted.  You will need a"
	eerror "separate copy of the kernel sources for each different machine-type"
	eerror "you want to build a kernel for."
	die "Only one machine-type patchset allowed"
}


# Check our USE flags for machine-specific flags and give appropriate warnings.
# Hope the user isn't crazy enough to try using combinations of these flags.
# Only use one machine-specific flag at a time for each type of desired machine-support.
pkg_setup() {
	local arch_is_selected="no"

	# See if we're using IP28 (Indigo2 Impact R10000)
	if use ip28; then
		if [ "${arch_is_selected}" = "no" ]; then
			echo -e ""
			einfo "Support for the Indigo2 Impact R10000 is probably even more experimental"
			einfo "than Octane support.  If you seriously do not have a clue in the world about"
			einfo "what you are doing, what an IP28 is, what a mips is, or even what gentoo is,"
			einfo "then stop now, and return to regularly scheduled x86 programming.  Consider"
			einfo "this the warning that you are about to venture into no-man's land with a"
			einfo "machine that is barely supported, likely very unstable, and may very well"
			einfo "eat your grandmother's pet cat Fluffy."
			echo -e ""
			einfo "That said, support for this system REQUIRES that you use the ip28 cascade"
			einfo "profile (default-linux/mips/mips64/ip28/XXXX.Y), because a very special"
			einfo "patch is used on the system gcc, kernel-gcc (gcc-mips64) and the kernel"
			einfo "itself in order to support this machine.  These patches will only be applied"
			einfo "if \"ip28\" is defined in USE, which the profile sets.  Other things to keep"
			einfo "in mind are that this system can only be netbooted (no arcboot support),"
			einfo "requires a full 64-bit kernel, serial-console only (Impact graphics not"
			einfo "supported yet), and _nothing_ is guaranteed to work smoothly."
			echo -e ""
			arch_is_selected="yes"
		else
			err_only_one_arch_allowed
		fi
	fi


	# See if we're using IP30 (Octane)
	if use ip30; then
		if [ "${arch_is_selected}" = "no" ]; then
			echo -e ""
			einfo "Octane Support is EXPERIMENTAL!  Note the use of caps and the word"
			einfo "EXPERIMENTAL.  That said, while current tests of Octane support"
			einfo "generally have worked well, there are some known drawbacks, including"
			einfo "lack of an X driver (Octane only works in console framebuffer for"
			einfo "now, but this will likely change).  Also, and this is important,"
			einfo "but you can ONLY use ONE scsi disk in the Octane.  Use of a second or"
			einfo "more disks will oops the kernel.  It is hoped the move to the qla1280"
			einfo "scsi driver will resolve this bug, but that is in the future.  For now,"
			einfo "the qlogicisp driver is the only thing available, and thus limits us to"
			einfo "one scsi disk."
			echo -e ""
			einfo "Also, Octane can only be netbooted.  There is no support for disk-booting"
			einfo "as of yet.  Disk-booting will require a 64bit Arcboot or an entirely new"
			einfo "bootloader, and both are non-existant at this point in time."
			echo -e ""
			arch_is_selected="yes"
		else
			err_only_one_arch_allowed
		fi
	fi


	# See if we're on a cobalt system (must use the cobalt-mips profile)
	if use cobalt; then
		if [ "${arch_is_selected}" = "no" ]; then
			echo -e ""
			einfo "Please keep in mind that the 2.6 kernel will NOT boot on Cobalt"
			einfo "systems that are still using the old Cobalt bootloader.  In"
			einfo "order to boot a 2.6 kernel on Cobalt systems, you must be using"
			einfo "Peter Horton's new bootloader, which does not have the kernel"
			einfo "size limitation that the older bootloader has.  If you want"
			einfo "to use the newer bootloader, make sure you have sys-boot/colo"
			einfo "installed and setup."
			echo -e ""
			arch_is_selected="yes"
		else
			err_only_one_arch_allowed
		fi
	fi
}



#//------------------------------------------------------------------------------



# Generic Patches - Safe to use globally
do_generic_patches() {
	echo -e ""
	ebegin ">>> Generic Patches"
		# IP32 Patches (Safe for non-IP32 use)
		epatch ${WORKDIR}/mips-patches/misc-2.6.10-ip32-onion2-gbefb-fixes.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6.10-ip32-tweak-makefile.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6.10-ths-mips-tweaks.patch

		# Generic
		epatch ${WORKDIR}/mips-patches/misc-2.6-fix-prologue-error.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6.10-add-ramdisk-back.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6-mips-iomap-functions.patch

		# Ugly Hacks (Long Story, ask about it on IRC if you really want to know)
		if ! use ip30 and ! use ip28; then
			epatch ${WORKDIR}/mips-patches/misc-2.6-ugly-wrong-kphysaddr-hack.patch
		fi
	eend
}


# NOT safe for production systems
# Use at own risk, do _not_ file bugs on effects of these patches
do_sekret_patches() {
	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */
	# Patches used in building LiveCDs
	if use livecd; then
		epatch ${WORKDIR}/mips-patches/misc-2.6-livecd-partitioned-cdroms.patch
	fi
	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */
}


do_security_patches() {
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		epatch ${WORKDIR}/security/CAN-2004-0883-2.6.9-smbfs_remote_overflows.patch
		epatch ${WORKDIR}/security/CAN-2004-1056-2.6.9-dos_drm.patch
		epatch ${WORKDIR}/security/CAN-2004-1235-2.6-uselib_priv_escalation.patch
		epatch ${WORKDIR}/security/CAN-2005-0001-2.6.10-prereq-grsec_mult_kern_adv.patch
		epatch ${WORKDIR}/security/CAN-2005-0001-2.6.10-i386_smp_page_fault_handler.patch
		epatch ${WORKDIR}/security/security-2.6.10-lsm-local_priv_elevate_flaw.patch
		epatch ${WORKDIR}/security/security-2.6-nfs-client-o_direct-error.patch
	eend
}



#//------------------------------------------------------------------------------



# These patches are separate from generic patches for a good reason - namely because it is
# possible (but untested) that patches for one machine-type may conflict with patches from
# another machine type and therefore produce unwanted side-effects.  We therefore enforce 
# this by checking if an arch patch has already been applied, and if so, error out.

# SGI Indigo2 Impact R10000 (IP28)
do_ip28_support() {
	echo -e ""
	einfo ">>> Patching kernel for SGI Indigo2 Impact R10000 (IP28) support ..."
	epatch ${WORKDIR}/mips-patches/misc-2.6.10-rc2-ip28-i2_impact-support.patch
	epatch ${WORKDIR}/mips-patches/misc-2.6.10-rc2-ip28-c_r4k-tweak.patch
	mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.ip28
	S="${S}.ip28"
}


# SGI Octane 'Speedracer' (IP30)
do_ip30_support() {
	echo -e ""
	einfo ">>> Patching kernel for SGI Octane (IP30) support ..."
	epatch ${WORKDIR}/mips-patches/misc-2.6.10-rc2-ip30-octane-support.patch
	mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.ip30
	S="${S}.ip30"
}


# Cobalt Microserver
do_cobalt_support() {
	echo -e ""
	einfo ">>> Patching kernel for Cobalt support ..."
	epatch ${WORKDIR}/mips-patches/misc-2.6.9-cobalt-support.patch
	mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.cobalt
	S="${S}.cobalt"
}



#//------------------------------------------------------------------------------



src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${STABLEVER} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}


	# If USERC == "yes", use a release candidate kernel (2.6.x-rcy)
	if [ "${USERC}" = "yes" ]; then
		echo -e ""
		einfo ">>> Applying ${OKV} patch ..."
		epatch ${WORKDIR}/patch-${OKV}
	fi


	# Update the vanilla sources with linux-mips CVS changes
	echo -e ""
	einfo ">>> Applying mipscvs-${CVSDATE} patch ..."
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Generic patches we always include
	do_generic_patches

	# Machine-specific patches
	use ip28	&& do_ip28_support
	use ip30	&& do_ip30_support
	use cobalt	&& do_cobalt_support

	# Patches for experimental use
	do_sekret_patches

	# Security Fixes
	do_security_patches


	# All done, resume normal portage work
	kernel_universal_unpack
}



#//------------------------------------------------------------------------------
