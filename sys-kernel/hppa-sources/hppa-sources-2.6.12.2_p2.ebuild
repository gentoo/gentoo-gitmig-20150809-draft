# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.6.12.2_p2.ebuild,v 1.3 2005/07/12 18:07:14 dertobi123 Exp $

ETYPE="sources"

CKV="${PV/_*}"
K_NOUSENAME=true
inherit kernel-2

KV_FULL=${CKV}-pa${PATCH_LEVEL}
detect_version



DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
PATCH_LEVEL="${PV/${CKV}_p/}"
SRC_URI="${KERNEL_URI}
http://ftp.parisc-linux.org/cvs/linux-2.6/patch-${OKV}-pa${PATCH_LEVEL}.gz"
UNIPATCH_LIST="${T}/patch-${OKV}-pa${PATCH_LEVEL}.patch
${FILESDIR}/4705_squashfs-2.1.patch.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="hppa -*"


src_unpack() {

	if [[ -n ${KV_EXTRA} ]]
	then

		KV_EXTRA=".${KV_EXTRA}"

		zcat ${DISTDIR}/patch-${OKV}-pa${PATCH_LEVEL}.gz | \
			sed -e "/+EXTRAVERSION/s/=.*\$/=/" > \
			${T}/patch-${OKV}-pa${PATCH_LEVEL}.patch
	fi

	EXTRAVERSION=${KV_EXTRA}-pa${PATCH_LEVEL}

	universal_unpack

	unipatch  ${UNIPATCH_LIST}
	unipatch  ${UNIPATCH_LIST_DEFAULT}

	unpack_set_extraversion
	unpack_fix_docbook
	unpack_fix_install_path

}
