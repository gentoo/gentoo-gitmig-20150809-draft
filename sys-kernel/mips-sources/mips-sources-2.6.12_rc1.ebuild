# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.12_rc1.ebuild,v 1.1 2005/03/25 02:30:09 kumba Exp $


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 20 Mar 2005
# 3) Generic Fixes
# 4) Security fixes
# 5) Patch for IP30 Octane Support		(http://helios.et.put.poznan.pl/~sskowron/ip30/)
# 6) Patch for Remaining Cobalt Bits		(http://www.colonel-panic.org/cobalt-mips/)
# 7) Experimental patches


#//------------------------------------------------------------------------------



# Version Data
OKV=${PV/_/-}
CVSDATE="20050320"			# Date of diff between kernel.org and lmo CVS
SECPATCHVER="1.11"			# Tarball version for security patches
GENPATCHVER="1.7"			# Tarball version for generic patches
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
USERC="yes"				# If set to "yes", then attempt to use an RC kernel

# Directories
S="${WORKDIR}/linux-${OKV}-${CVSDATE}"
MIPS_PATCHES="${WORKDIR}/mips-patches"
MIPS_SECURITY="${WORKDIR}/security"

# Inherit Eclasses 
ETYPE="sources"
inherit kernel eutils

# Portage Vars
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* ~mips"
IUSE="cobalt ip28 ip30 livecd nptl"

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
#
# Affected machines:	ip30 ip28
# Not Affected:		cobalt ip32
pkg_setup() {
	local arch_is_selected="no"

	# See if we're using IP28 (Indigo2 Impact R10000)
	if use ip28; then
		eerror "!!! IP28 Support not available for this release"
		die
#//		if [ "${arch_is_selected}" = "no" ]; then
#//			echo -e ""
#//			einfo "Support for the Indigo2 Impact R10000 is probably even more experimental"
#//			einfo "than Octane support.  If you seriously do not have a clue in the world about"
#//			einfo "what you are doing, what an IP28 is, what a mips is, or even what gentoo is,"
#//			einfo "then stop now, and return to regularly scheduled x86 programming.  Consider"
#//			einfo "this the warning that you are about to venture into no-man's land with a"
#//			einfo "machine that is barely supported, likely very unstable, and may very well"
#//			einfo "eat your grandmother's pet cat Fluffy."
#//			echo -e ""
#//			einfo "That said, support for this system REQUIRES that you use the ip28 cascade"
#//			einfo "profile (default-linux/mips/mips64/ip28/XXXX.Y), because a very special"
#//			einfo "patch is used on the system gcc, kernel-gcc (gcc-mips64) and the kernel"
#//			einfo "itself in order to support this machine.  These patches will only be applied"
#//			einfo "if \"ip28\" is defined in USE, which the profile sets.  Other things to keep"
#//			einfo "in mind are that this system can only be netbooted (no arcboot support),"
#//			einfo "requires a full 64-bit kernel, serial-console only (Impact graphics not"
#//			einfo "supported yet), and _nothing_ is guaranteed to work smoothly."
#//			echo -e ""
#//			arch_is_selected="yes"
#//		else
#//			err_only_one_arch_allowed
#//		fi
	fi


	# See if we're using IP30 (Octane)
	if use ip30; then
		if [ "${arch_is_selected}" = "no" ]; then
			echo -e ""
			einfo "Octane support is still considered experimental, but runs reasonably"
			einfo "well.  There is still the limitation of using only one SCSI disk (two"
			einfo "or more will panic the kernel), serial is still limited to 96008N1, and"
			einfo "there is no X support as of this release.  Framebuffer Console only"
			einfo "works on ImpactSR, no VPro support yet, and Octane can only be netbooted"
			einfo "for the time being."
			echo -e ""
			einfo "SMP on Octane is also available with this release, however it is still"
			einfo "in testing and thus should be considered very experimental."
			echo -e ""
			arch_is_selected="yes"
		else
			err_only_one_arch_allowed
		fi
	fi


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
		arch_is_selected="yes"
	fi
}



#//------------------------------------------------------------------------------



# Generic Patches - Safe to use globally
do_generic_patches() {
	echo -e ""
	ebegin ">>> Generic Patches"
		# IP32 Patches (Safe for non-IP32 use)
		epatch ${MIPS_PATCHES}/misc-2.6.12-ip32-onion2-gbefb-fixes.patch
		epatch ${MIPS_PATCHES}/misc-2.6.10-ip32-tweak-makefile.patch

		# Cobalt Patches (Safe for non-Cobalt use)
		epatch ${MIPS_PATCHES}/misc-2.6.12-cobalt-bits.patch

		# Generic
		epatch ${MIPS_PATCHES}/misc-2.6.11-ths-mips-tweaks.patch
		epatch ${MIPS_PATCHES}/misc-2.6.11-add-ramdisk-back.patch
		epatch ${MIPS_PATCHES}/misc-2.6-mips-iomap-functions.patch
		epatch ${MIPS_PATCHES}/misc-2.6.11-smptlb-64bit-fix.patch
		epatch ${MIPS_PATCHES}/misc-2.6.12-seccomp-no-default.patch


		# Ugly Hacks (Long Story, ask about it on IRC if you really want to know)
		if ! use ip30 and ! use ip28; then
			epatch ${MIPS_PATCHES}/misc-2.6.11-ugly-wrong-kphysaddr-hack.patch
		fi
	eend
}


# NOT safe for production systems
# Use at own risk, do _not_ file bugs on effects of these patches
do_sekret_patches() {
	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */
	# Patches used in building LiveCDs
	if use livecd; then
		epatch ${MIPS_PATCHES}/misc-2.6-livecd-partitioned-cdroms.patch
	fi
	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */

	# Insanity knows no bounds
	if use nptl; then
		echo -e ""
		einfo ">>> Let the insanity begin ..."
		epatch ${MIPS_PATCHES}/misc-2.6.12-nptl-support.patch
	fi
}


do_security_patches() {
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		einfo "None to Apply!"
	eend
}



#//------------------------------------------------------------------------------



# These patches are separate from generic patches for a good reason - namely because it is
# possible (but untested) that patches for one machine-type may conflict with patches from
# another machine type and therefore produce unwanted side-effects.  We therefore enforce 
# this by checking if an arch patch has already been applied, and if so, error out.

# SGI Indigo2 Impact R10000 (IP28)
#// do_ip28_support() {
#//	echo -e ""
#//	einfo ">>> Patching kernel for SGI Indigo2 Impact R10000 (IP28) support ..."
#//	epatch ${MIPS_PATCHES}/misc-2.6.10-rc2-ip28-i2_impact-support.patch
#//	epatch ${MIPS_PATCHES}/misc-2.6.10-rc2-ip28-c_r4k-tweak.patch
#//	mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.ip28
#//	S="${S}.ip28"
#// }


# SGI Octane 'Speedracer' (IP30)
do_ip30_support() {
	echo -e ""
	einfo ">>> Patching kernel for SGI Octane (IP30) support ..."
	epatch ${MIPS_PATCHES}/misc-2.6.12-rc1-ip30-octane-support.patch
	epatch ${MIPS_PATCHES}/misc-2.6.11-cgs-ioc3-eth-dow.patch
	mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.ip30
	S="${S}.ip30"
}



#//------------------------------------------------------------------------------



src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${STABLEVER} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}


	# If USERC == "yes", use a release candidate kernel (2.6.x-rcy)
	if [ "${USERC}" = "yes" ]; then
		echo -e ""
		einfo ">>> linux-${STABLEVER} --> linux-${OKV} ..."
		epatch ${WORKDIR}/patch-${OKV}
	fi


	# Update the vanilla sources with linux-mips CVS changes
	echo -e ""
	einfo ">>> linux-${OKV} --> linux-${OKV}-${CVSDATE} patch ..."
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
