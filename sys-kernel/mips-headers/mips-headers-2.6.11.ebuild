# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.6.11.ebuild,v 1.2 2005/03/26 20:35:26 kumba Exp $

# Eclass bits
ETYPE="headers"
H_SUPPORTEDARCH="mips"
UNIPATCH_STRICTORDER="1"
inherit kernel-2
detect_version

# Version Data
OKV=${PV/_/-}
CVSDATE="20050314"                      # Date of diff between kernel.org and lmo CVS
GENPATCHVER="1.7"                       # Tarball version for generic patches
HEAPATCHVER="1.0"
EXTRAVERSION="-mipscvs-${CVSDATE}"

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 15 Jan 2005
# 4) Generic mips patches

DESCRIPTION="Linux Headers from Linux-Mips CVS, dated ${CVSDATE}"
##SRC_URImirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
SRC_URI="${KERNEL_URI}
	mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
	mirror://gentoo/mips-sources-generic_patches-${GENPATCHVER}.tar.bz2
	mirror://gentoo/mips-headers-patches-${HEAPATCHVER}.tar.bz2"

HOMEPAGE="http://www.linux-mips.org/ http://www.kernel.org/ http://www.gentoo.org/"
SLOT="0"
PROVIDE="virtual/os-headers"
KEYWORDS="-* ~mips"
IUSE="ip30 nptl"


UNIPATCH_LIST="
	${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff
	${WORKDIR}/mips-patches/misc-${PV}-ths-mips-tweaks.patch
	${WORKDIR}/mips-patches/misc-2.6-mips-iomap-functions.patch
	${WORKDIR}/mips-patches-h/${P}-ip27-build64.patch
	${WORKDIR}/mips-patches-h/linux-headers-2.6.0-sysctl_h-compat.patch
	${WORKDIR}/mips-patches-h/linux-headers-2.6.0-fb.patch
	${WORKDIR}/mips-patches-h/linux-headers-2.6.8.1-strict-ansi-fix.patch
	${WORKDIR}/mips-patches-h/linux-headers-${PV}-appCompat.patch
	${WORKDIR}/mips-patches-h/${P}-appCompat.patch"


# IP30 (Octane) support? (includes additonal headers)
if use ip30; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.11-rc4-ip30-octane-support.patch"
fi


# Insanity?
if use nptl; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.12-nptl-support.patch"
fi


src_unpack() {
	
	# unpack ${A} unapcks kernel sources a second time, which we don't want
	local my_a=${A/linux-${OKV}.tar.bz2/}
	unpack ${my_a}

	# kernel-2 stuff
	tc-arch-kernel
	kernel-2_src_unpack
}

src_compile() {
	# Set the right defconfig
	K_DEFCONFIG=""
	if use cobalt; then
		K_DEFCONFIG="cobalt_defconfig"
	else
		# SGI Machine?
		case "$(uname -i)" in
			"SGI Indy"|"SGI Indigo2"|"SGI IP22")    K_DEFCONFIG="ip22_defconfig" ;;
			"SGI Origin"|"SGI IP27")                K_DEFCONFIG="ip27_defconfig" ;;
			"SGI Octane"|"SGI IP30")                K_DEFCONFIG="ip27_defconfig" ;;
			"SGI O2"|"SGI IP32")                    K_DEFCONFIG="ip32_defconfig" ;;
		esac
	fi

	# Compile
	kernel-2_src_compile
}
