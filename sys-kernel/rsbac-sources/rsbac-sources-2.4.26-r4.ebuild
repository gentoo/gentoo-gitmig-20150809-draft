# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-sources/rsbac-sources-2.4.26-r4.ebuild,v 1.1 2004/08/05 01:20:22 kang Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2
detect_version

# rsbac 
RSBACV=1.2.3
RSBAC_SRC="http://rsbac.org/download/code/v${RSBACV}/rsbac-v${RSBACV}.tar.bz2"
CAN_SRC="http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.4.26-CAN-2004-0415.patch"

# rsbac kernel patches
RGPV=26.7
RGPV_SRC="mirror://rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2 http://dev.gentoo.org/~zhware/rsbac/v${RSBACV}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="	${FILESDIR}/${PN}-2.4.CAN-2004-0495.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0535.patch
	${FILESDIR}/${PN}-CAN-2004-0497.patch
	${DISTDIR}/linux-2.4.26-CAN-2004-0415.patch
	${DISTDIR}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2
	${FILESDIR}/${PN}-v1.2.3-3.patch"
UNIPATCH_DOCS="${WORKDIR}/patches/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}/0000_README"

HOMEPAGE="http://hardened.gentoo.org/rsbac"
DESCRIPTION="RSBAC hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${RSBAC_SRC} ${RGPV_SRC} ${CAN_SRC}"
KEYWORDS="x86"


src_unpack() {
	universal_unpack
	cd ${WORKDIR}/linux-${KV}; unpack rsbac-v${RSBACV}.tar.bz2
	unipatch "${UNIPATCH_LIST}"
	[ -z "${K_NOSETEXTRAVERSION}" ] && unpack_set_extraversion
	unpack_2_4
}

pkg_postinst() {
	postinst_sources
}
