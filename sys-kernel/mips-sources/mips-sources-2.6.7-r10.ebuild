# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.6.7-r10.ebuild,v 1.1 2004/12/01 11:15:23 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040621"			# Date of diff between kernel.org and lmo CVS
COBALTPATCHVER="1.5"			# Tarball version for cobalt patches
SECPATCHVER="1.6"			# Tarball version for security patches
GENPATCHVER="1.0"                       # Tarball version for generic patches
IP32DIFFDATE="20040402"			# Date of diff of iluxa's minpatchset
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 21 Jun 2004
# 3) Patch to fix an O2 compile-time error
# 4) Iluxa's minimal O2 Patchset
# 5) Security fixes
# 6) patch to fix iptables build failures
# 7) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		cobalt? ( mirror://gentoo/cobalt-patches-26xx-${COBALTPATCHVER}.tar.bz2 )"

HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-*"
IUSE="cobalt"


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
}

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Fix a compile glitch for SGI O2/IP32
	echo -e ""
	einfo ">>> Generic Patches"
	epatch ${WORKDIR}/mips-patches/mipscvs-2.6.7-maceisa_rtc_irq-fix.patch

	# Misc Fixes
	epatch ${WORKDIR}/mips-patches/misc-2.6-iptables_headers.patch

	# Force detection of PS/2 mice on SGI Systems
	epatch ${WORKDIR}/mips-patches/misc-2.6-force_mouse_detection.patch

	# Something happened to compat_alloc_user_space between 2.6.6 and 2.6.7 that
	# Breaks ifconfig.
	epatch ${WORKDIR}/mips-patches/misc-2.6-compat_alloc_user_space.patch

	# iluxa's minpatchset for SGI O2
	echo -e ""
	einfo ">>> Patching kernel with iluxa's minimal IP32 patchset ..."
	epatch ${WORKDIR}/ip32-iluxa-minpatchset-${IP32DIFFDATE}.diff


	# Security Fixes
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		epatch ${WORKDIR}/security/CAN-2004-0415-2.6.7-file_offset_pointers.patch
		epatch ${WORKDIR}/security/CAN-2004-0497-attr_gid.patch
		epatch ${WORKDIR}/security/CAN-2004-0596-2.6-eql.patch
		epatch ${WORKDIR}/security/CAN-2004-0626-death_packet.patch
		epatch ${WORKDIR}/security/CAN-2004-0814-2.6.7-tty_race_conditions.patch
		epatch ${WORKDIR}/security/CAN-2004-0816-2.6-iptables_dos.patch
		epatch ${WORKDIR}/security/CAN-2004-0883-2.6.8.1-smbfs_remote_overflows.patch
		epatch ${WORKDIR}/security/security-2.6-attr_check.patch
		epatch ${WORKDIR}/security/security-2.6-proc_race.patch
		epatch ${WORKDIR}/security/security-2.6.7-binfmt_elf-fixes.patch
		epatch ${WORKDIR}/security/security-2.6-remote_ddos.patch
		epatch ${WORKDIR}/security/security-2.6.7-mips-ptrace.patch
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

	kernel_universal_unpack
}
