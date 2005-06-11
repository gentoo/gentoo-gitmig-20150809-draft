# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.31.ebuild,v 1.1 2005/06/11 20:50:28 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20050606"			# Date of diff between kernel.org and lmo CVS
SECPATCHVER="1.14"			# Tarball version for security patches
GENPATCHVER="1.12"			# Tarball version for generic patches
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


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/${PN}-security_patches-${SECPATCHVER}.tar.bz2
		mirror://gentoo/${PN}-generic_patches-${GENPATCHVER}.tar.bz2"

HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* mips"
IUSE=""


src_unpack() {
	unpack ${A}

	echo -e ""
	einfo "Ignore warnings about using the 'linux-info' eclass."
	echo -e ""

	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# gcc-3.4.x compatibility patches
	epatch ${WORKDIR}/mips-patches/misc-2.4-gcc-3.4.x-strcpy-fix.patch
	epatch ${WORKDIR}/mips-patches/misc-2.4-gcc-3.4.x-stop-dead-code-elim.patch


	# Security Fixes
#	echo -e ""
#	ebegin ">>> Applying Security Fixes"
#	eend

	kernel_universal_unpack
}
