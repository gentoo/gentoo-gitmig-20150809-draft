# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.6.10.ebuild,v 1.2 2005/03/19 20:38:22 vapier Exp $

# Eclass bits
ETYPE="headers"
H_SUPPORTEDARCH="mips"
inherit kernel-2
detect_version

# Version Data
OKV=${PV/_/-}
CVSDATE="20050115"                      # Date of diff between kernel.org and lmo CVS
GENPATCHVER="1.6"                       # Tarball version for generic patches
EXTRAVERSION="-mipscvs-${CVSDATE}"

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 15 Jan 2005
# 4) Generic mips patches

DESCRIPTION="Linux Headers from Linux-Mips CVS, dated ${CVSDATE}"
##SRC_URImirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
SRC_URI="mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
	mirror://gentoo/mips-sources-generic_patches-${GENPATCHVER}.tar.bz2"

HOMEPAGE="http://www.linux-mips.org/ http://www.kernel.org/ http://www.gentoo.org/"
SLOT="0"
[[ ${CTARGET} == ${CHOST} ]] && PROVIDE="virtual/os-headers"
KEYWORDS="-* ~mips"
IUSE="cobalt ip30"


# We reference patches from linux-headers, so copy from there
LHN="linux-headers"			# Name
LHV="${PV}"				# Version
LHC="sys-kernel"			# Category
LHP="${PORTDIR}/${LHC}/${LHN}/files"	# Path


UNIPATCH_LIST="
	${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff
	${WORKDIR}/mips-patches/misc-2.6.10-ths-mips-tweaks.patch
	${WORKDIR}/mips-patches/misc-2.6-mips-iomap-functions.patch
	${FILESDIR}/${P}-ip27-build64.patch
	${LHP}/${LHN}-2.6.0-sysctl_h-compat.patch
	${LHP}/${LHN}-2.6.0-fb.patch
	${LHP}/${LHN}-2.6.8.1-strict-ansi-fix.patch
	${LHP}/${LHN}-${LHV}-appCompat.patch"

# Cobalt support? (includes additonal headers)
if use cobalt; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.9-cobalt-support.patch"
fi

# IP30 (Octane) support? (includes additonal headers)
if use ip30; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.10-rc2-ip30-octane-support.patch"
fi

src_unpack() {
	unpack ${A}
	tc-arch-kernel
	kernel-2_src_unpack

#	# Fixes ... all the mv magic is to keep sed from dumping 
#	# ugly warnings about how it can't work on a directory.
#	cd ${S}/include
#	mv asm-ia64/sn asm-ppc64/iSeries .
#	headers___fix asm-ia64/*
#	mv sn asm-ia64/
#	headers___fix asm-ppc64/*
#	mv iSeries asm-ppc64/
#	headers___fix asm-ppc64/iSeries/*
#	headers___fix linux/{ethtool,jiffies}.h
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
