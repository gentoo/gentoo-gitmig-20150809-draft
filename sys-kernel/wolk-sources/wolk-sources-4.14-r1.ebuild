# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.14-r1.ebuild,v 1.1 2004/06/04 17:53:14 plasmaroo Exp $

OKV="2.4.20"
OKB="2.4"
EXTRAVERSION="-${PN%-*}-${PV/$OKV./}-${PR}"
KV="${OKV}${EXTRAVERSION}"
S="${WORKDIR}/linux-${KV}"
WOLK_SRC="linux-${OKV}-wolk${PV/${OKV}./}-fullkernel.tar.bz2"
WOLK_DIR="linux-${OKV}-wolk${PV/${OKV}./}-fullkernel"

ETYPE="sources"
inherit kernel-2

RESTRICT="nomirror"
DESCRIPTION="Full sources for Marc-Christian Peterson's WOLK kernel, based on 2.4.20 vanilla with many popular patches and fixes"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/mcp/${OKB}-WOLK/"
SRC_URI="mirror://kernel/linux/kernel/people/mcp/${OKB}-WOLK/${WOLK_SRC}"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips"

K_EXTRAEINFO="If there are issues with this kernel, then please direct any queries to the
mailing list: http://sourceforge.net/mailarchive/forum.php?forum_id=8245.
Refer to the 2.4-WOLK-README file for further information. You will find
this file in the directory containing the sources."

UNIPATCH_LIST="${FILESDIR}/${PN}.CAN-2004-0133.patch
	${FILESDIR}/${PN}.CAN-2004-0181.patch
	${FILESDIR}/${PN}.CAN-2004-0394.patch"

#============================================================================
# We'll override the src_unpack() function from the eclass. This is necessary
# due to the inclusion of optional patches in the sources. These cannot be
# applied until after the initial base WOLK patch has been applied which is
# a problem, given that the eclass checks for the validity of any patches.
#============================================================================
src_unpack() {
	cd ${WORKDIR}
	unpack ${WOLK_SRC}
	mv ${WOLK_DIR} linux-${KV} || die "Unable to move source tree to ${KV}."
	cd ${S}

	unipatch ${UNIPATCH_LIST}
	universal_unpack
	unpack_set_extraversion
}
