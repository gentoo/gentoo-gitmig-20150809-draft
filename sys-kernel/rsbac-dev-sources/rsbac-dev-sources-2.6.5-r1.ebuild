# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-dev-sources/rsbac-dev-sources-2.6.5-r1.ebuild,v 1.1 2004/06/14 22:24:42 plasmaroo Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2
detect_version

# rsbac 
RSBACV=1.2.3
REL="-pre5"
RSBAC_SRC="mirror://rsbac-v${RSBACV}${REL}.tar.bz2 http://zeus.polsl.gliwice.pl/~albeiro/rsbac/v$RSBACV/rsbac-v${RSBACV}${REL}.tar.bz2"

# rsbac kernel patches
RGPV=5.3
RGPV_SRC="mirror://rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2 http://zeus.polsl.gliwice.pl/~albeiro/rsbac/v${RSBACV}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"
# exclude 12xx grsec and 13xx selinux patches
UNIPATCH_EXCLUDE="12 13"
UNIPATCH_LIST="${DISTDIR}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2
	${FILESDIR}/${PN}.CAN-2004-0075.patch
	${FILESDIR}/${PN}.CAN-2004-0228.patch
	${FILESDIR}/${PN}.CAN-2004-0229.patch
	${FILESDIR}/${PN}.CAN-2004-0427.patch
	${FILESDIR}/${PN}.FPULockup-53804.patch"
UNIPATCH_DOCS="${WORKDIR}/patches/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}/0000_README"

HOMEPAGE="http://www.gentoo.org/proj/en/hardened/rsbac"
DESCRIPTION="RSBAC hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${RSBAC_SRC} ${RGPV_SRC} ${GPV_SRC}"
KEYWORDS="~x86"

src_unpack() {
	universal_unpack
	(cd ${WORKDIR}/linux-${KV}; unpack rsbac-v${RSBACV}${REL}.tar.bz2)
	[ -n "${UNIPATCH_LIST}" -o -n "${UNIPATCH_LIST_DEFAULT}" ] && unipatch "${UNIPATCH_LIST_DEFAULT} ${UNIPATCH_LIST}"
	[ -z "${K_NOSETEXTRAVERSION}" ] && unpack_set_extraversion
	[ $(kernel_is_2_4) $? == 0 ] && unpack_2_4
}

pkg_postinst() {
	postinst_sources
}
