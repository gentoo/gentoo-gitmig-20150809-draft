# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.9.ebuild,v 1.1 2004/10/21 22:42:11 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20041021"			# Date of diff between kernel.org and lmo CVS
#IP30DATE=""				# Date of diff for IP30 (Octane) patches - XXX - Not Implemented Yet
COBALTPATCHVER="1.8"			# Tarball version for cobalt patches
SECPATCHVER="1.2"			# Tarball version for security patches
GENPATCHVER="1.1"			# Tarball version for generic patches
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 14 Aug 2004
# 3) Generic Fixes
# 4) Security fixes
# 5) Patches for Cobalt support


HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-*"
IUSE="cobalt"
#IUSE="cobalt ip30 ip27"

DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		cobalt? ( mirror://gentoo/cobalt-patches-26xx-${COBALTPATCHVER}.tar.bz2 )"
#		ip30? ( mirror://gentoo/ip30-patches-${IP30DATE}.tar.bz2 )			# IP30 Patches - XXX - Not Implemented
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

#	# See if we're using IP30 (Octane) - XXX - Not Implemented
#	if use ip30; then
#		echo -e ""
#		einfo ""
#		echo -e ""
#	fi

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
		# IP32 Patches
		epatch ${WORKDIR}/mips-patches/misc-2.6-ip32-onion2-gbefb-fixes-old.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6.9-ths-ip32-misc.patch

		# Generic
		epatch ${WORKDIR}/mips-patches/misc-2.6-force_mouse_detection.patch
		epatch ${WORKDIR}/mips-patches/misc-2.6-fix-prologue-error.patch
	eend


#	# Security Fixes
#	echo -e ""
#	ebegin ">>> Applying Security Fixes"
#	eend


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


#	# IP30 (Octane) Patch - XXX - Not Implemented
#	if use ip30; then
#		echo -e ""
#		einfo ">>> Patching kernel for SGI Octane (IP30) support ..."
#	fi

#	# IP27 (Origin) Hacks - XXX - Not Implemented
#	if use ip27; then
#		echo -e ""
#		einfo ">>> Patching kernel for SGI Origin (IP27) support ..."
#	fi


	kernel_universal_unpack
}
