# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.6.14.4.ebuild,v 1.2 2006/04/30 17:48:21 kumba Exp $

# Eclass bits
ETYPE="headers"
H_SUPPORTEDARCH="mips"
UNIPATCH_STRICTORDER="1"
inherit kernel-2 versionator
detect_version

# Version Data
OKV=${PV/_/-}
GITDATE="20051030"			# Date of diff between kernel.org and lmo GIT
GENPATCHVER="1.16"			# Tarball version for generic patches
HEAPATCHVER="1.3"
F_KV="${OKV}"
EXTRAVERSION="-mipsgit-${GITDATE}"
USEPNT="yes"

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org GIT snapshot diff from 15 Jan 2005
# 4) Generic mips patches


# If USEPNT == "yes", use a point release kernel (2.6.x.y)
if [ "${USEPNT}" = "yes" ]; then
	F_KV="$(get_version_component_range 1-3)"
	PNT_KV="$(get_version_component_range 4)"
	EXTRAVERSION=".${PNT_KV}-mipsgit-${GITDATE}"
	KV="${OKV}${EXTRAVERSION}"
	OKV="${F_KV}"
fi

DESCRIPTION="Linux Headers from Linux-Mips GIT, dated ${GITDATE}"
SRC_URI="${KERNEL_URI}
	mirror://gentoo/mipsgit-${OKV}-${GITDATE}.diff.bz2
	mirror://gentoo/mips-sources-generic_patches-${GENPATCHVER}.tar.bz2
	mirror://gentoo/mips-headers-patches-${HEAPATCHVER}.tar.bz2"

HOMEPAGE="http://www.linux-mips.org/ http://www.kernel.org/ http://www.gentoo.org/"
KEYWORDS="-* mips"
IUSE="ip27 ip28 ip30 cobalt"

UNIPATCH_LIST="
	${WORKDIR}/mipsgit-${OKV}-${GITDATE}.diff
	${WORKDIR}/mips-patches/misc-2.6.14-ths-mips-tweaks.patch
	${WORKDIR}/mips-patches/misc-2.6.14-mips-iomap-functions.patch
	${WORKDIR}/mips-patches/misc-2.6.14-rev-i18n.patch
	${WORKDIR}/mips-patches-h/${PN}-2.6.13-ip27-build64.patch
	${WORKDIR}/mips-patches-h/linux-headers-2.6.0-sysctl_h-compat.patch
	${WORKDIR}/mips-patches-h/linux-headers-2.6.0-fb.patch
	${WORKDIR}/mips-patches-h/linux-headers-2.6.8.1-strict-ansi-fix.patch
	${WORKDIR}/mips-patches-h/linux-headers-2.6.14-appCompat.patch
	${WORKDIR}/mips-patches-h/${PN}-2.6.14-appCompat.patch"


# IP27 (Origin) support? (includes additonal headers)
if use ip27; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.14-ioc3-metadriver-r26.patch"
fi

# IP28 (Indigo2 Impact R10000) support? (includes additonal headers)
if use ip28; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.14-ip28-i2_impact-support.patch"
fi

# IP30 (Octane) support? (includes additonal headers)
if use ip30; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.14-ioc3-metadriver-r26.patch"
	UNIPATCH_LIST="${UNIPATCH_LIST} ${WORKDIR}/mips-patches/misc-2.6.14-ip30-octane-support-r27.patch"
fi


src_unpack() {

	# unpack ${A} unapcks kernel sources a second time, which we don't want
	local my_a=${A/linux-${OKV}.tar.bz2/}
	unpack ${my_a}


	# kernel-2 stuff
	kernel-2_src_unpack

	# fix headers
	cd ${S}
	headers___fix include/asm-mips/*.h
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
