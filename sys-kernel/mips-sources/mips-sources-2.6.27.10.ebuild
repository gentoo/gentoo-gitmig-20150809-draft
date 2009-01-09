# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.27.10.ebuild,v 1.2 2009/01/09 08:38:50 kumba Exp $

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org GIT snapshot diff from 12 Dec 2008
# 3) Generic Fixes
# 4) Patch for the IOC3 Metadriver (IP27, IP30)
# 5) Patch for IP30 Support
# 6) Patch for IP28 Graphics Support (SolidImpact)
# 7) Experimental patches (if needed)

#//------------------------------------------------------------------------------

# Version Data
OKV=${PV/_/-}
GITDATE="20081230"			# Date of diff between kernel.org and lmo GIT
GENPATCHVER="1.34"			# Tarball version for generic patches
EXTRAVERSION="-mipsgit-${GITDATE}"
KV="${OKV}${EXTRAVERSION}"
F_KV="${OKV}"				# Fetch KV, used to know what mipsgit diff to grab.
STABLEVER="${F_KV}"			# Stable Version (2.6.x)
PATCHVER=""

# Directories
S="${WORKDIR}/linux-${OKV}-${GITDATE}"
MIPS_PATCHES="${WORKDIR}/mips-patches"

# Inherit Eclasses
ETYPE="sources"
inherit kernel eutils versionator

# Portage Vars
HOMEPAGE="http://www.linux-mips.org/ http://www.gentoo.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources virtual/alsa"
KEYWORDS="-* ~mips"
IUSE="cobalt ip27 ip28 ip30 ip32r10k"
DEPEND=">=sys-devel/gcc-4.1.1"

# Version Control Variables
USE_RC="no"				# If set to "yes", then attempt to use an RC kernel
USE_PNT="yes"				# If set to "yes", then attempt to use a point-release (2.6.x.y)

# Machine Support Control Variables
DO_IP22="yes"				# If "yes", enable IP22 support		(SGI Indy, Indigo2 R4x00)
DO_IP27="yes"				# 		   IP27 support		(SGI Origin)
DO_IP28="yes"				# 		   IP28 support		(SGI Indigo2 Impact R10000)
DO_IP30="yes"				# 		   IP30 support		(SGI Octane)
DO_IP32="yes"				# 		   IP32 support		(SGI O2, R5000/RM5200 Only)
DO_CBLT="test"				# 		   Cobalt Support	(Cobalt Microsystems)

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
		mirror://gentoo/mipsgit-${F_KV}-${GITDATE}.diff.lzma
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		${PATCHVER}"

#//------------------------------------------------------------------------------

# Error/Warning messages
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
	local need_test="${4}"

	# Get stable version, if exists
	local stable_ver="SV_${mach_abbr}"
	stable_ver="${!stable_ver}"

	# See if this machine needs a USE passed or skip dying
	local has_use
	[ ! -z "${mach_use}" -a "${mach_use}" != "skip" ] && has_use="USE=\"${mach_use}\" "

	# Print error && (maybe) die
	echo -e ""
	if [ "${need_test}" != "test" ]; then
		eerror "${mach_name} Support has been disabled in this ebuild"
		eerror "revision.  If you wish to merge ${mach_name} sources, then"
		eerror "run ${has_use}emerge =mips-sources-${stable_ver}"
		[ "${mach_use}" != "skip" ] && die "${mach_name} Support disabled."
	else
		ewarn "${mach_name} Support has been marked as needing testing in this"
		ewarn "ebuild revision.  This usually means that any patches to support"
		ewarn "${mach_name} have been forward ported and maybe even compile-tested,"
		ewarn "but not yet booted on real hardware, possibly due to a lack of access"
		ewarn "to such hardware.  If you happen to boot this kernel and have no"
		ewarn "problems at all, then please inform the maintainer.  Otherwise, if"
		ewarn "experience a bug, an oops/panic, or some other oddity, then please"
		ewarn "file a bug at bugs.gentoo.org, and assign it to the mips team."
	fi

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
	einfo "IP22 systems with an R5000 processor should work well with this release."
	einfo "The R4x00 series of processors tend to be rather flaky, especially the"
	einfo "R4600.  If you have to run an R4x00 processor, then try to use an R4400."
	einfo ""
	einfo "Some Notes:"
	einfo "\t- Supported graphics card right now is Newport (XL)."
	einfo "\t- A driver for Extreme (XZ) supposedly exists, but its author"
	einfo "\t\040\040has steadfastly refused to release the code for various reasons."
	einfo "\t\040\040Any questions regarding its status should be directed to "onion" in"
	einfo "\t\040\040#mipslinux on the Freenode IRC network.  Given he is the author, he"
	einfo "\t\040\040will know the most current status of the driver."
	echo -e ""
}

show_ip27_info() {
	echo -e ""
	ewarn "IP27 support can be considered a game of Russian Roulette.  It'll work"
	ewarn "great for some but not for others.  We don't get a chance to test this"
	ewarn "machine very often with each new kernel, so your mileage may vary."
	echo -e ""
}

show_ip28_info() {
	echo -e ""
	einfo "Support for the Indigo2 Impact R10000 is now in the mainline kernel.  However,"
	einfo "due to the R10000 Speculative Execution issue that exists with this machine,"
	einfo "nothing is guaranteed to work correctly.  Consider enabling ${HILITE}CONFIG_KALLSYMS${NORMAL}"
	einfo "in your kernel so that if the machine Oopes, you'll be able to provide valuable"
	einfo "feedback that can be used to trace down the crash."
	echo -e ""
}

show_ip30_info() {
	echo -e ""
	einfo "Things to keep in mind when building a kernel for an SGI Octane:"
	einfo "\t- Impact (MGRAS) console and X driver work, please report any bugs."
	einfo "\t- VPro (Odyssey) console works, but no X driver exists yet."
	einfo "\t- PCI Card Cages should work for many devices, except certain types like"
	einfo "\t\040\040PCI-to-PCI bridges (USB hubs, USB flash card readers for example)."
	einfo "\t- Do not use OHCI-based USB cards in Octane.  They're broke on this machine."
	einfo "\t\040\040Patches are welcome to fix the issue."
	einfo "\t- Equally, UHCI Cards are showing issues in this release, but should still"
	einfo "\t\040\040function somewhat.  This issue manifests itself when using pl2303 USB->Serial"
	einfo "\t\040\040adapters."
	einfo "\t- Other XIO-based devices like MENET and various Impact addons remain"
	einfo "\t\040\040untested and are not guaranteed to work.  This applies to various"
	einfo "\t\040\040digital video conversion boards as well."
	echo -e ""
}

show_ip32_info() {
	echo -e ""
	einfo "IP32 systems function well, however there are some notes:"
	einfo "\t- A sound driver now exists for IP32.  Celebrate!"
	einfo "\t- Framebuffer console is limited to 4MB.  Anything greater"
	einfo "\t\040\040specified when building the kernel will likely oops or panic"
	einfo "\t\040\040the kernel."
	einfo "\t- X support is limited to the generic fbdev driver.  No X gbefb"
	einfo "\t\040\040driver exists for O2 yet.  Patches are welcome, however! :)"
	echo -e ""

	if use ip32r10k; then
		eerror "R10000/R12000 Support on IP32 is ${HILITE}HIGHLY EXPERIMENTAL!${NORMAL}"
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
	fi

	eerror "!!! BIG FAT WARNING"
	eerror "!!! To Build 64bit kernels for SGI O2 (IP32) or SGI Indy/Indigo2 R4x00 (IP22)"
	eerror "!!! systems, you _need_ to be using a >=gcc-4.1.1 compiler, have CONFIG_BUILD_ELF64"
	eerror "!!! disabled in your kernel config, and building with the ${HILITE}vmlinux.32${NORMAL} make target."
	eerror ""
	eerror "!!! Once done, copy the ${GOOD}vmlinux.32${NORMAL} file and boot that.  Do not use the"
	eerror "!!! ${BAD}vmlinux${NORMAL} file -- this will either not boot on IP22 or result in"
	eerror "!!! undocumented weirdness on IP32 systems."
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
		[ "${DO_CBLT}" = "test" ] 						\
			&& err_disabled_mach "Cobalt Microsystems" "CBLT" "cobalt" "test"
		[ "${DO_CBLT}" = "no" ] 						\
			&& err_disabled_mach "Cobalt Microsystems" "CBLT" "cobalt"
		show_cobalt_info
	fi

	# Exclusive machine patchsets
	# These are not allowed to be mixed together, thus only one of them may be applied
	# to a tree per merge.
	for x in									\
		"ip27 SGI Origin 200/2000"						\
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

			# Is the machine support disabled or marked as needing testing?
			[ "${mach_enable}" = "test" ]					\
				&& err_disabled_mach "${mach_name}" "${mach_ip/ip/IP}" "${mach_ip}" "test"
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

		# IP22 Patches
		epatch ${MIPS_PATCHES}/misc-2.6.16-ip22-vino-64bit-ioctl-fixes.patch

		# IP32 Patches
		epatch ${MIPS_PATCHES}/misc-2.6.11-ip32-mace-is-always-eth0.patch

		# Generic
		epatch ${MIPS_PATCHES}/misc-2.6.27-ths-mips-tweaks.patch
		epatch ${MIPS_PATCHES}/misc-2.6.23-seccomp-no-default.patch
		epatch ${MIPS_PATCHES}/misc-2.6.11-add-byteorder-to-proc.patch
		epatch ${MIPS_PATCHES}/misc-2.6.24-ip32-rm7k-l3-support.patch
		epatch ${MIPS_PATCHES}/misc-2.6.27-enable-old-rtc-drivers.patch
		epatch ${MIPS_PATCHES}/misc-2.6.27-squashfs-3.4.patch
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
		epatch ${MIPS_PATCHES}/misc-2.6.20-ip32-r10k-support.patch
	fi

##	# No Sekrit Patches!
##	sleep 0

	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */
}

#//------------------------------------------------------------------------------

# Exclusive Machine Patchsets

# SGI Origin (IP27)
do_ip27_support() {
	echo -e ""
	einfo ">>> Patching the kernel for SGI Origin 200/2000 (IP27) support ..."
	epatch "${MIPS_PATCHES}"/misc-2.6.27-ioc3-metadriver-r27.patch
	epatch "${MIPS_PATCHES}"/misc-2.6.22-ioc3-revert_commit_691cd0c.patch
}

# SGI Indigo2 Impact R10000 (IP28)
do_ip28_support() {
	echo -e ""
	einfo ">>> Patching the kernel for SGI Indigo2 Impact R10000 (IP28) Graphics support ..."
	epatch "${MIPS_PATCHES}"/misc-2.6.27-ip28-solidimpact-gfx.patch
}

# SGI Octane 'Speedracer' (IP30)
do_ip30_support() {
	echo -e ""
	einfo ">>> Patching the kernel for SGI Octane (IP30) support ..."
	epatch "${MIPS_PATCHES}"/misc-2.6.27-ioc3-metadriver-r27.patch
	epatch "${MIPS_PATCHES}"/misc-2.6.27-ip30-octane-support-r28.patch
	epatch "${MIPS_PATCHES}"/misc-2.6.22-ioc3-revert_commit_691cd0c.patch
}

#//------------------------------------------------------------------------------

# Renames source trees for the few machines that we have separate patches for
rename_source_tree() {
	if [ ! -z "${1}" ]; then
		if use ${1}; then
			mv "${S}" "${S}.${1}"
			S="${S}.${1}"
		fi
	fi
}

#//------------------------------------------------------------------------------

src_unpack() {
	local x

	unpack ${A}
	mv "${WORKDIR}/linux-${STABLEVER}" "${WORKDIR}/linux-${OKV}-${GITDATE}"
	cd "${S}"

	# If USE_RC == "yes", use a release candidate kernel (2.6.x-rcy)
	# OR
	# if USE_PNT == "yes", use a point-release kernel (2.6.x.y)
	if [ "${USE_RC}" = "yes" -o "${USE_PNT}" = "yes" ]; then
		echo -e ""
		einfo ">>> linux-${STABLEVER} --> linux-${OKV} ..."
		epatch "${WORKDIR}/patch-${OKV}"
	fi

	# Update the vanilla sources with linux-mips GIT changes
	echo -e ""
	einfo ">>> linux-${OKV} --> linux-${OKV}-${GITDATE} patch ..."
	epatch "${WORKDIR}/mipsgit-${F_KV}-${GITDATE}.diff"

	# Generic patches we always include
	do_generic_patches

	# Machine-specific patches
	for x in {ip27,ip28,ip30}; do
		use ${x} && do_${x}_support
	done

	# Patches for experimental use
	do_sekrit_patches

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

	if [ ! -e "${ROOT}usr/src/linux" ]; then
		rm -f "${ROOT}usr/src/linux"
		ln -sf "${my_ksrc}" "${ROOT}/usr/src/linux"
	fi
}

#//------------------------------------------------------------------------------
