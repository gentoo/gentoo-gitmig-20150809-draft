# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.26-r14.ebuild,v 1.1 2004/12/03 06:29:45 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040712"			# Date of diff between kernel.org and lmo CVS
COBALTPATCHVER="1.4"			# Tarball version for cobalt patches
SECPATCHVER="1.8"			# Tarball version for security patches
GENPATCHVER="1.0"			# Tarball version for generic patches
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 12 Jul 2004
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) patch to fix the mips64 Makefile to allow building of mips64 kernels
# 5) iso9660 fix
# 6) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2
		cobalt? ( mirror://gentoo/cobalt-patches-24xx-${COBALTPATCHVER}.tar.bz2 )"

HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* mips"
IUSE="cobalt"


src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	echo -e ""
	einfo ">>> Generic Patches"
	epatch ${WORKDIR}/mips-patches/mipscvs-${OKV}-makefile-fix.patch

	# Security Fixes
	echo -e ""
	ebegin ">>> Applying Security Fixes"
		epatch ${WORKDIR}/security/CAN-2004-0394-panic.patch
		epatch ${WORKDIR}/security/CAN-2004-0415-2.4-file_offset_pointers.patch
		epatch ${WORKDIR}/security/CAN-2004-0495-2.4-sparse.patch
		epatch ${WORKDIR}/security/CAN-2004-0497-attr_gid.patch
		epatch ${WORKDIR}/security/CAN-2004-0535-2.4-e1000.patch
		epatch ${WORKDIR}/security/CAN-2004-0685-2.4-conectiva_usb.patch
		epatch ${WORKDIR}/security/CAN-2004-0814-2.4.26-tty_race_conditions.patch
		epatch ${WORKDIR}/security/CAN-2004-0883-2.4-smbfs_remote_overflows.patch
		epatch ${WORKDIR}/security/CAN-2004-1074-2.4-kernel_dos_vma.patch
		epatch ${WORKDIR}/security/security-2.4-proc_race.patch
		epatch ${WORKDIR}/security/security-2.4-binfmt_elf-fixes.patch
		epatch ${WORKDIR}/security/security-2.4-remote_ddos.patch
		epatch ${WORKDIR}/security/security-2.4-mips-ptrace.patch
		epatch ${WORKDIR}/security/security-2.4-af_unix-kern-mem.patch
	eend


	# Cobalt Patches
	if use cobalt; then
		echo -e ""
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
		cp ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/cobalt-patches.txt ${S}
		cd ${WORKDIR}
		mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.cobalt
		S="${S}.cobalt"
	fi

	kernel_universal_unpack
}
