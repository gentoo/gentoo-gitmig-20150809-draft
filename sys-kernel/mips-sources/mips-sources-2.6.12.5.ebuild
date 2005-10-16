# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.12.5.ebuild,v 1.1 2005/10/16 02:31:27 kumba Exp $


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 11 Jul 2005
# 3) Generic Fixes
# 4) Security fixes
# 7) Experimental patches (IP27)


#//------------------------------------------------------------------------------



# Version Data
OKV=${PV/_/-}
CVSDATE="20050711"			# Date of diff between kernel.org and lmo CVS
SECPATCHVER="1.15"			# Tarball version for security patches
GENPATCHVER="1.14"			# Tarball version for generic patches
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
F_KV="${OKV}"				# Fetch KV, used to know what mipscvs diff to grab.
STABLEVER="${F_KV}"			# Stable Version (2.6.x)
PATCHVER=""
USERC="no"				# If set to "yes", then attempt to use an RC kernel
USEPNT="yes"				# If set to "yes", then attempt to use a point-release (2.6.x.y)

# Directories
S="${WORKDIR}/linux-${OKV}-${CVSDATE}"
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
IUSE="ip27"


# If USERC == "yes", use a release candidate kernel (2.6.X-rcY)
# Do not set this to "yes" if using a point-release kernel
if [ "${USERC}" = "yes" ]; then
	KVXY="$(get_version_component_range 1-2)"			# Kernel Major/Minor
	KVZ="$(get_version_component_range 3)"				# Kernel Revision Pt. 1
	KVRC="${get_version_component_range 4}"				# Kernel RC
	F_KV="$(get_version_component_range 1-3)"
	STABLEVER="${KVXY}.$((${KVZ} - 1))"				# Last stable version (Rev - 1)
	PATCHVER="mirror://kernel/linux/kernel/v2.6/testing/patch-${OKV}.bz2"
	EXTRAVERSION="-${KVRC}-mipscvs-${CVSDATE}"
	KV="${OKV}-${EXTRAVERSION}"
fi

# If USEPNT == "yes", use a point release kernel (2.6.x.y)
# Do not set this to "yes" if using a release candidate kernel
if [ "${USEPNT}" = "yes" ]; then
	F_KV="$(get_version_component_range 1-3)"			# Get Maj/Min/Rev (x.y.z)
	STABLEVER="${F_KV}"						# Last Revision release
	PATCHVER="mirror://kernel/linux/kernel/v2.6/patch-${OKV}.bz2"	# Patch for new point release
	EXTRAVERSION=".$(get_version_component_range 4)-mipscvs-${CVSDATE}"
	KV="${OKV}${EXTRAVERSION}"
fi


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${STABLEVER}.tar.bz2
		mirror://gentoo/mipscvs-${F_KV}-${CVSDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		${PATCHVER}"



#//------------------------------------------------------------------------------



# Error message 
err_only_one_arch_allowed() {
	echo -e ""
	die "IP27 Support pre-selected"
}


# Check our USE flags for machine-specific flags and give appropriate warnings.
# Hope the user isn't crazy enough to try using combinations of these flags.
# Only use one machine-specific flag at a time for each type of desired machine-support.
#
# Affected machines:	ip27
# Not Affected:
pkg_setup() {
	local arch_is_selected="no"

	# See if we're using IP27 (Origin)
	if use ip27; then
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
		arch_is_selected="yes"
	else
		echo -e ""
		eerror "Only support for the SGI Origin is enabled in this version."
		eerror "Please pass USE=\"ip27\" or add this USE flag to /etc/make.conf."
		err_only_one_arch_allowed
	fi
}



#//------------------------------------------------------------------------------



# Generic Patches - Safe to use globally
do_generic_patches() {
	echo -e ""
	ebegin ">>> Generic Patches"
		# Generic
		epatch ${MIPS_PATCHES}/misc-2.6.12-ths-mips-tweaks.patch
		epatch ${MIPS_PATCHES}/misc-2.6.12-mips-iomap-functions.patch
		epatch ${MIPS_PATCHES}/misc-2.6.12-seccomp-no-default.patch
		epatch ${MIPS_PATCHES}/misc-2.6.11-add-byteorder-to-proc.patch
		epatch ${MIPS_PATCHES}/misc-2.6.13-n32-fix-sigsuspend.patch
		epatch ${MIPS_PATCHES}/misc-2.6.12-patch-2_6_13_4-backport.patch
	eend
}


# NOT safe for production systems
# Use at own risk, do _not_ file bugs on effects of these patches
do_sekrit_patches() {
	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */

	# No Sekrit Patches!
	sleep 0

	# /* EXPERIMENTAL - DO NOT USE IN PRODUCTION KERNELS */
}


do_security_patches() {
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		einfo ">>> None to apply! ..."
		echo -e ""
##		epatch ${MIPS_SECURITY}/
	eend
}



#//------------------------------------------------------------------------------



# These patches are separate from generic patches for a good reason - namely because it is
# possible (but untested) that patches for one machine-type may conflict with patches from
# another machine type and therefore produce unwanted side-effects.  We therefore enforce 
# this by checking if an arch patch has already been applied, and if so, error out.

# SGI Origin (IP27)
do_ip27_support() {
	echo -e ""
	einfo ">>> Patching kernel for SGI Origin (IP27) support ..."
	epatch ${MIPS_PATCHES}/misc-2.6.12-ioc3-metadriver-r25.patch
	epatch ${MIPS_PATCHES}/misc-2.6.12-ip27-iluxa-fixes.patch
	epatch ${MIPS_PATCHES}/misc-2.6.13-ip27-horrible-hacks_may-eat-kittens.patch
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
	unpack ${A}
	mv ${WORKDIR}/linux-${STABLEVER} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}


	# If USERC == "yes", use a release candidate kernel (2.6.x-rcy)
	# OR
	# if USEPNT == "yes", use a point-release kernel (2.6.x.y)
	if [ "${USERC}" = "yes" -o "${USEPNT}" = "yes" ]; then
		echo -e ""
		einfo ">>> linux-${STABLEVER} --> linux-${OKV} ..."
		epatch ${WORKDIR}/patch-${OKV}
	fi


	# Update the vanilla sources with linux-mips CVS changes
	echo -e ""
	einfo ">>> linux-${OKV} --> linux-${OKV}-${CVSDATE} patch ..."
	epatch ${WORKDIR}/mipscvs-${F_KV}-${CVSDATE}.diff

	# Generic patches we always include
	do_generic_patches

	# Machine-specific patches
	use ip27	&& do_ip27_support

	# Patches for experimental use
	do_sekrit_patches

	# Security Fixes
	do_security_patches


	# All done, resume normal portage work
	kernel_universal_unpack
}


src_install() {
	use ip27	&& rename_source_tree ip27

	kernel_src_install
}

pkg_postinst() {
	local my_ksrc="${S##*/}"
	use ip27	&& my_ksrc="${my_ksrc}.ip27"

	if [ ! -e ${ROOT}usr/src/linux ]; then
		rm -f ${ROOT}usr/src/linux
		ln -sf ${my_ksrc} ${ROOT}/usr/src/linux
	fi
}


#//------------------------------------------------------------------------------
