# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-dev-sources/rsbac-dev-sources-2.6.7-r6.ebuild,v 1.1 2004/10/22 11:57:07 kang Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2
detect_version

# rsbac 
RSBACV=1.2.3
RSBAC_SRC="http://rsbac.org/download/code/v${RSBACV}/rsbac-v${RSBACV}.tar.bz2"
CAN_SRC="http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.6.7-CAN-2004-0415.patch"

# rsbac kernel patches
RGPV=7.1
RGPV_SRC="mirror://rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${FILESDIR}/${PN}-iptables-dos.patch
	${FILESDIR}/${PN}-CAN-2004-0497.patch
	${FILESDIR}/${PN}-CAN-2004-0596.patch
	${FILESDIR}/${OKV}-cmdline.patch
	${FILESDIR}/${PN}-CAN-2004-0816.patch
	${DISTDIR}/linux-2.6.7-CAN-2004-0415.patch
	${DISTDIR}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2
	${FILESDIR}/${PN}-v1.2.3-3.patch"
UNIPATCH_DOCS="${WORKDIR}/patches/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}/0000_README"

HOMEPAGE="http://hardened.gentoo.org/rsbac/"
DESCRIPTION="RSBAC hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${RSBAC_SRC} ${RGPV_SRC} ${CAN_SRC}"
KEYWORDS="x86"


src_unpack() {
	universal_unpack
	(cd ${WORKDIR}/linux-${KV}; unpack rsbac-v${RSBACV}.tar.bz2)
	unipatch "${UNIPATCH_LIST_DEFAULT} ${UNIPATCH_LIST}"
	[ -z "${K_NOSETEXTRAVERSION}" ] && unpack_set_extraversion
}

pkg_postinst() {
	postinst_sources
	ewarn "Please configure and compile your RSBAC kernel before installing rsbac-admin tools"
}
