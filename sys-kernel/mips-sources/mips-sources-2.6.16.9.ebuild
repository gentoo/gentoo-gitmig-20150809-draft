# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.16.9.ebuild,v 1.1 2006/04/22 01:46:15 kumba Exp $


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org GIT snapshot diff from 14 Sep 2005
# 3) Generic Fixes
# 4) Security fixes
# 5) Patch for IP30 Support			(http://www.linux-mips.org/~skylark/)
# 5) Patch for IP28 Support			(http://home.alphastar.de/fuerst/download.html)
# 6) Patch for Remaining Cobalt Bits		(http://www.colonel-panic.org/cobalt-mips/)
# 7) Experimental patches (IP27 hacks, et al)


#//------------------------------------------------------------------------------



# Version Data
OKV=${PV/_/-}
GITDATE="20060320"			# Date of diff between kernel.org and lmo GIT
SECPATCHVER="1.15"			# Tarball version for security patches
GENPATCHVER="1.21"			# Tarball version for generic patches
EXTRAVERSION="-mipsgit-${GITDATE}"
KV="${OKV}${EXTRAVERSION}"
F_KV="${OKV}"				# Fetch KV, used to know what mipsgit diff to grab.
STABLEVER="${F_KV}"			# Stable Version (2.6.x)
PATCHVER=""

# Directories
S="${WORKDIR}/linux-${OKV}-${GITDATE}"
MIPS_PATCHES="${WORKDIR}/mips-patches"
MIPS_SECURITY="${WORKDIR}/security"

# Inherit Eclasses
ETYPE="sources"
inherit kernel eutils versionator

# Portage Vars
HOMEPAGE="http://www.linux-mips.org/ http://www.gentoo.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources virtual/alsa"
KEYWORDS="-* ~mips"
IUSE="cobalt ip27 ip28 ip30 ip32r10k"
DEPEND=">=sys-devel/gcc-3.4.6"


# Version Control Variables
USE_RC="no"				# If set to "yes", then attempt to use an RC kernel
USE_PNT="yes"				# If set to "yes", then attempt to use a point-release (2.6.x.y)

# Machine Support Control Variables
DO_IP22="yes"				# If "yes", enable IP22 support		(SGI Indy, Indigo2 R4x00)
DO_IP27="yes"				# 		   IP27 support		(SGI Origin)
DO_IP28="yes"				# 		   IP28 support		(SGI Indigo2 Impact R10000)
DO_IP30="yes"				# 		   IP30 support		(SGI Octane)
DO_IP32="yes"				# 		   IP32 support		(SGI O2, R5000/RM5200 Only)
DO_CBLT="yes"				# 		   Cobalt Support	(Cobalt Microsystems)

# Machine Stable Version Variables 
SV_IP22=""				# If set && DO_IP22 == "no", indicates last "good" IP22 version
SV_IP27=""				# 	    DO_IP27 == "no", 			   IP27
SV_IP28=""				# 	    DO_IP28 == "no", 			   IP28
SV_IP30=""				# 	    DO_IP30 == "no", 			   IP30
SV_IP32=""				# 	    DO_IP32 == "no", 			   IP32
SV_CBLT=""				# 	    DO_CBLT == "no", 			   Cobalt


# If USE_RC == "yes", use a release candidate kernel (2.6.X-rcY)
if [ "${USE_RC}" = "yes" ]; then
	KVXY="$(get_version_component_range 1-2)"			# Kernel Major/Minor
	KVZ="$(get_version_component_range 3)"				# Kernel Revision Pt. 1
	KVRC="$(get_version_component_range 4)"				# Kernel RC
	F_KV="$(get_version_component_range 1-3)-${KVRC}"
	STABLEVER="${KVXY}.$((${KVZ} - 1))"				# Last stable version (Rev - 1)
	PATCHVER="mirror://kernel/linux/kernel/v2.6/testing/patch-${OKV}.bz2"
	EXTRAVERSION="-${KVRC}-mipsgit-${GITDATE}"
	KV="${OKV}-${EXTRAVERSION}"
	USE_PNT="no"
fi

# If USE_PNT == "yes", use a point release kernel (2.6.x.y)
if [ "${USE_PNT}" = "yes" ]; then
	F_KV="$(get_version_component_range 1-3)"			# Get Maj/Min/Rev (x.y.z)
	STABLEVER="${F_KV}"						# Last Revision release
	PATCHVER="mirror://kernel/linux/kernel/v2.6/patch-${OKV}.bz2"	# Patch for new point release
	EXTRAVERSION=".$(get_version_component_range 4)-mipsgit-${GITDATE}"
	KV="${OKV}${EXTRAVERSION}"
	USE_RC="no"
fi


DESCRIPTION="Linux-Mips GIT sources for MIPS-based machines, dated ${GITDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${STABLEVER}.tar.bz2
		mirror://gentoo/mipsgit-${F_KV}-${GITDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		${PATCHVER}"



#//------------------------------------------------------------------------------



# Error messages
err_only_one_mach_allowed() {
	echo -e ""
	eerror "A patchset for a specific machine-type has already been selected."
	eerror "No other patches for machines-types are permitted.  You will need a"
	eerror "separate copy of the kernel sources for each different machine-type"
	eerror "you want to build a kernel for."
	die "Only one machine-type patchset allowed"
}

err_disabled_mach() {
	# Get args
	local mach_name="${1}"
	local mach_abbr="${2}"
	local mach_use="${3}"

	# Get stable version, if exists
	local stable_ver="SV_${mach_abbr}"
	stable_ver="${!stable_ver}"

	# See if this machine needs a USE passed or skip dying
	local has_use
	[ ! -z "${mach_use}" -a "${mach_use}" != "skip" ] && has_use="USE=\"${mach_use}\" "

	# Print error && (maybe) die
	echo -e ""
	eerror "${mach_name} Support has been disabled in this ebuild"
	eerror "revision.  If you wish to merge ${mach_name} sources, then"
	eerror "run ${has_use}emerge =mips-sources-${stable_ver}"
	[ "${mach_use}" != "skip" ] && die "${mach_name} Support disabled."

	return 0
}



#//------------------------------------------------------------------------------



# Machine Information Messages
#
# If needing to whitespace for formatting in 'einfo', 'ewarn', or 'eerror', use
# \040 for a space instead of the standard space.  These functions strip redundant
# white space for some unknown reason

show_ip22_info() {
	echo -e ""
	einfo "IP22 systems should work well with this release, however, R4600"
	einfo "setups may still experience bugs.  Please report any encountered"
	einfo "problems."
	einfo ""
	einfo "Some Notes:"
	einfo "\t- Supported graphics card right now is Newport (XL)."
	einfo "\t- A driver for Extreme (XZ) is in the works, but remains"
	einfo "\t\040\040unreleased by its author for public consumption."
	einfo "\t- 64bit support works, but it is not widely tested, thus"
	einfo "\t\040\040it is not supported at the present time."
	echo -e ""
}

show_ip27_info() {
	echo -e ""
	einfo "IP27 support can be considered a game of Russian Roulette.  It'll work"
	einfo "great for some but not for others.  It also uses some rather horrible"
	einfo "hacks to get going -- hopefully these will be repaired in the future."
	echo -e ""
	ewarn "Please keep all kittens and any other small, cute, and fluffy creatures"
	ewarn "away from an IP27 Box running these sources.  Failure to do so may cause"
	ewarn "the IP27 to consume the hapless creature.  Consider this your only"
	ewarn "warning regarding the experimental nature of this particular machine."
	echo -e ""
}

show_ip28_info() {
	echo -e ""
	einfo "Support for the Indigo2 Impact R10000 is very experimental.  If you do not"
	einfo "have a clue in the world about what an IP28 is, what the mips architecture"
	einfo "is about, or are new to Gentoo, then it is highly advised that you steer"
	einfo "clear of messing with this machine.  Due to the experimental nature of this"
	einfo "particular class of system, we have to provide such warnings, as it is only"
	einfo "for use by those who know what they are doing."
	echo -e ""
	einfo "Be advised that attempting to run Gentoo/Linux (or any Linux distro) on this"
	einfo "system may cause the sudden, unexplained disappearence of any nearby furry"
	einfo "creatures.  So please keep any and all small pets away from this system at"
	einfo "all times."
	echo -e ""
	ewarn "That said, support for this system REQUIRES that you use the ip28 cascade"
	ewarn "profile (default-linux/mips/mips64/ip28/XXXX.Y), because a very special"
	ewarn "patch is used on the system gcc, kernel-gcc (gcc-mips64) and the kernel"
	ewarn "itself in order to support this machine.  These patches will only be applied"
	ewarn "if \"ip28\" is defined in USE, which the profile sets.  If you wish to"
	ewarn "cross-compile a kernel, you _must_ make sure that the \"ip28\" USE is"
	ewarn "defined in your host system's /etc/make.conf file before using crossdev"
	ewarn "to build a mips64 kernel compiler for this system."
	echo -e ""
	ewarn "As a final warning, _nothing_ is guaranteed to work smoothly.  However,"
	ewarn "the Impact console driver and X driver do work somewhat decently."
	echo -e ""
}

show_ip30_info() {
	echo -e ""
	einfo "Things to keep in mind when building a kernel for an SGI Octane:"
	einfo "\t- The scsi driver to use is qla1280; qlogicisp is gone."
	einfo "\t- Impact (MGRAS) console and X driver work, please report any bugs."
	einfo "\t- VPro (Odyssey) console works, but no X driver exists yet."
	einfo "\t- PCI Card Cages should work for many devices, except certain types like"
	einfo "\t\040\040PCI-to-PCI bridges (USB hubs, USB flash card readers for example)."
	einfo "\t- Do not plug more than two devices into a OHCI-based USB PCI card, as"
	einfo "\t\040\040there is a known problem with OHCI USB cards and Octane, which will"
	einfo "\t\040\040prevent the machine from booting into userland."
	einfo "\t- Other XIO-based devices like MENET and various Impact addons remain"
	einfo "\t\040\040untested and are not guaranteed to work.  This applies to various"
	einfo "\t\040\040digital video conversion boards as well."
	echo -e ""
}

show_ip32_info() {
	echo -e ""
	einfo "IP32 systems function well, however there are some notes:"
	einfo "\t- No driver exists yet for the sound card."
	einfo "\t- Framebuffer console is limited to 4MB.  Anything greater"
	einfo "\t\040\040specified when building the kernel will likely oops or panic"
	einfo "\t\040\040the kernel."
	einfo "\t- X support is limited to the generic fbdev driver.  No X gbefb"
	einfo "\t\040\040driver exists for O2 yet."
	ewarn "\t- When building an O2 Kernel, do not enable CONFIG_BUILD_ELF64."
	ewarn "\t\040\040Pass 'make vmlinux' instead, and you will get a bootable"
	ewarn "\t\040\040kernel image.  Please note, this behavior WILL change"
	ewarn "\t\040\040when gcc-4.x becomes mainstream."
	echo -e ""

	if use ip32r10k; then
		eerror "R10000/R12000 Support on IP32 is HIGHLY EXPERIMENTAL!"
		eerror "This is intended ONLY for people interested in fixing it up.  And"
		eerror "by that, I mean people willing to SEND IN PATCHES!  If you're not"
		eerror "interested in debugging this issue seriously or just want to run it"
		eerror "as a user, then DO NOT USE THIS.  Really, we mean it."
		echo -e ""
		eerror "All that said, initial testing seems to indicate that this system will"
		eerror "stay online for a reasonable amount of time and will compile packages."
		eerror "However, the primary console (which is serial, gbefb seems dead for now)"
		eerror "will fill with CRIME CPU errors every so often.  A majority of these"
		eerror "seem harmless, however a few non-fatal oopses have also been triggered."
		echo -e ""
		eerror "We're interesting in finding anyone with knowledge of the R10000"
		eerror "workaround for speculative execution listed in the R10000 Processor"
		eerror "manual, or those who are familiar with the IP32 chipset and the feature"
		eerror "called \"Juice\"."
		echo -e ""
		eerror "To build this kernel tree, make sure you re-merge your kernel compiler"
		eerror "with the \"ip32r10k\" USE flag enabled via crossdev.  This uses a"
		eerror "tweaked version of the gcc cache barriers patch that makes gcc emit "
		eerror "more barriers, as IP32 needs them to have any hope of staying online."
	fi
}

show_cobalt_info() {
	echo -e ""
	einfo "Please keep in mind that the 2.6 kernel will NOT boot on Cobalt"
	einfo "systems that are still using the old Cobalt bootloader.  In"
	einfo "order to boot a 2.6 kernel on Cobalt systems, you must be using"
	einfo "the CoLo bootloader, which does not have the kernel"
	einfo "size limitation that the older bootloader has.  If you want"
	einfo "to use the newer bootloader, make sure you have sys-boot/colo"
	einfo "installed and setup."
	echo -e ""
}



#//------------------------------------------------------------------------------



# Check our USE flags for machine-specific flags and give appropriate warnings/errors.
# Hope the user isn't crazy enough to try using combinations of these flags.
# Only use one machine-specific flag at a time for each type of desired machine-support.
#
# Affected machines:	ip27 ip28 ip30
# Not Affected:		cobalt ip22 ip32
pkg_setup() {
	local arch_is_selected="no"
	local mach_ip
	local mach_enable
	local mach_name
	local x

	# See if we're on a cobalt system first (must use the cobalt-mips profile)
	if use cobalt; then
		arch_is_selected="yes"
		[ "${DO_CBLT}" = "no" ] && err_disabled_mach "Cobalt Microsystems" "CBLT" "cobalt"
		show_cobalt_info
	fi

	# Exclusive machine patchsets
	# These are not allowed to be mixed together, thus only one of them may be applied
	# to a tree per merge.
	for x in									\
		"ip27 SGI Origin"							\
		"ip28 SGI Indigo2 Impact R10000"					\
		"ip30 SGI Octane"
	do
		set -- ${x}		# Set positional params
		mach_ip="${1}"		# Grab the first param (HW IP for SGI)
		shift			# Shift the positions
		mach_name="${*}"	# Get the rest (Name)

		if use ${mach_ip}; then
			# Fetch the value indiciating if the machine is enabled or not
			mach_enable="DO_${mach_ip/ip/IP}"
			mach_enable="${!mach_enable}"

			# Make sure only one of these exclusive machine patches is selected
			[ "${arch_is_selected}" = "no" ]				\
				&& arch_is_selected="yes"				\
				|| err_only_one_mach_allowed

			# Is the machine support enabled or not?
			[ "${mach_enable}" = "no" ]					\
				&& err_disabled_mach "${mach_name}" "${mach_ip/ip/IP}" "${mach_ip}"

			# Show relevant information about the machine
			show_${mach_ip}_info
		fi
	done

	# All other systems that don't have a USE flag go here
	# These systems have base-line support included in linux-mips git, so
	# instead of failing, if disabled, we simply warn the user
	if [ "${arch_is_selected}" = "no" ]; then
		[ "${DO_IP22}" = "no" ]							\
			&& err_disabled_mach "SGI Indy/Indigo2 R4x00" "IP22" "skip"	\
			|| show_ip22_info
		[ "${DO_IP32}" = "no" ]							\
			&& err_disabled_mach "SGI O2" "IP32" "skip"			\
			|| show_ip32_info

	fi
}



#//------------------------------------------------------------------------------



# Generic Patches - Safe to use globally
do_generic_patches() {
	echo -e ""
	ebegin ">>> Generic Patches"
		echo -e ""

		# IP22 Patches
		epatch ${MIPS_PATCHES}/misc-2.6.15-ip22-hal2-kconfig-tweaks.patch
		epatch ${MIPS_PATCHES}/misc-2.6.16-ip22-vino-64bit-ioctl-fixes.patch

		# IP32 Patches
		epatch ${MIPS_PATCHES}/misc-2.6.10-ip32-tweak-makefile.patch
		epatch ${MIPS_PATCHES}/misc-2.6.11-ip32-mace-is-always-eth0.patch

		# Cobalt Patches
		epatch ${MIPS_PATCHES}/misc-2.6.16-cobalt-bits.patch

		# Generic
		epatch ${MIPS_PATCHES}/misc-2.6.16-ths-mips-tweaks.patch
		epatch ${MIPS_PATCHES}/misc-2.6.15-mips-iomap-functions.patch
		epatch ${MIPS_PATCHES}/misc-2.6.12-seccomp-no-default.patch
		epatch ${MIPS_PATCHES}/misc-2.6.11-add-byteorder-to-proc.patch
		epatch ${MIPS_PATCHES}/misc-2.6.15-r14k-cpu-prid.patch
		epatch ${MIPS_PATCHES}/misc-2.6.15-add-4k_cache_defines.patch
		epatch ${MIPS_PATCHES}/misc-2.6.16-rev-i18n.patch
		epatch ${MIPS_PATCHES}/misc-2.6.15-fix-4k-cache-macros.patch
		epatch ${MIPS_PATCHES}/misc-2.6.15-vgacon-accesses-unmapped-space.patch
	eend
}


# NOT safe for production systems
# Use at own risk, do _not_ file bugs on effects of these patches
do_sekrit_patches() {
	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */

	if use ip32r10k; then
		# Modified version of the IP28 cache barriers patch for the kernel
		# that removes all the IP28 specific pieces and leaves behind only
		# the generic segments.
		epatch ${MIPS_PATCHES}/misc-2.6.16-ip32-r10k-support.patch
	fi

##	# No Sekrit Patches!
##	sleep 0

	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */
}


do_security_patches() {
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		echo -e ""
		einfo ">>> None to apply! ..."
		echo -e ""
##		epatch ${MIPS_SECURITY}/
	eend
}



#//------------------------------------------------------------------------------



# Exclusive Machine Patchsets

# SGI Origin (IP27)
do_ip27_support() {
	echo -e ""
	einfo ">>> Patching kernel for SGI Origin (IP27) support ..."
	epatch ${MIPS_PATCHES}/misc-2.6.16-ioc3-metadriver-r26.patch
	epatch ${MIPS_PATCHES}/misc-2.6.13-ip27-horrible-hacks_may-eat-kittens.patch
	epatch ${MIPS_PATCHES}/misc-2.6.14-ip27-rev-pci-tweak.patch
}

# SGI Indigo2 Impact R10000 (IP28)
do_ip28_support() {
	echo -e ""
	einfo ">>> Patching kernel for SGI Indigo2 Impact R10000 (IP28) support ..."
	epatch ${MIPS_PATCHES}/misc-2.6.16-ip28-i2_impact-support.patch
}


# SGI Octane 'Speedracer' (IP30)
do_ip30_support() {
	echo -e ""
	einfo ">>> Patching kernel for SGI Octane (IP30) support ..."
	epatch ${MIPS_PATCHES}/misc-2.6.16-ioc3-metadriver-r26.patch
	epatch ${MIPS_PATCHES}/misc-2.6.16-ip30-octane-support-r27.patch
}



#//------------------------------------------------------------------------------



# Renames source trees for the few machines that we have separate patches for
rename_source_tree() {
	if [ ! -z "${1}" ]; then
		if use ${1}; then
			mv ${S} ${S}.${1}
			S="${S}.${1}"
		fi
	fi
}



#//------------------------------------------------------------------------------



src_unpack() {
	local x

	unpack ${A}
	mv ${WORKDIR}/linux-${STABLEVER} ${WORKDIR}/linux-${OKV}-${GITDATE}
	cd ${S}


	# If USE_RC == "yes", use a release candidate kernel (2.6.x-rcy)
	# OR
	# if USE_PNT == "yes", use a point-release kernel (2.6.x.y)
	if [ "${USE_RC}" = "yes" -o "${USE_PNT}" = "yes" ]; then
		echo -e ""
		einfo ">>> linux-${STABLEVER} --> linux-${OKV} ..."
		epatch ${WORKDIR}/patch-${OKV}
	fi


	# Update the vanilla sources with linux-mips GIT changes
	echo -e ""
	einfo ">>> linux-${OKV} --> linux-${OKV}-${GITDATE} patch ..."
	epatch ${WORKDIR}/mipsgit-${F_KV}-${GITDATE}.diff

	# Generic patches we always include
	do_generic_patches

	# Machine-specific patches
	for x in {ip27,ip28,ip30}; do
		use ${x} && do_${x}_support
	done

	# Patches for experimental use
	do_sekrit_patches

	# Security Fixes
	do_security_patches


	# All done, resume normal portage work
	kernel_universal_unpack
}


src_install() {
	# Rename the source trees for exclusive machines
	local x
	for x in {ip27,ip28,ip30,cobalt}; do
		use ${x} && rename_source_tree ${x}
	done

	kernel_src_install
}

pkg_postinst() {
	# Symlink /usr/src/linux as appropriate
	local my_ksrc="${S##*/}"
	for x in {ip27,ip28,ip30,cobalt}; do
		use ${x} && my_ksrc="${my_ksrc}.${x}"
	done

	if [ ! -e ${ROOT}usr/src/linux ]; then
		rm -f ${ROOT}usr/src/linux
		ln -sf ${my_ksrc} ${ROOT}/usr/src/linux
	fi
}


#//------------------------------------------------------------------------------
