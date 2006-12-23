# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.6.19.1.ebuild,v 1.1 2006/12/23 11:45:26 gmsoft Exp $

ETYPE="sources"

inherit kernel-2

detect_version

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
PATCH_LEVEL="0"
SRC_URI="${KERNEL_URI}
http://dev.gentoo.org/~gmsoft/patches/patch-${OKV}-pa${PATCH_LEVEL}.gz
mirror://gentoo/4300_squashfs-3.0.patch.bz2"
UNIPATCH_LIST="${T}/patch-${OKV}-pa${PATCH_LEVEL}.patch
${DISTDIR}/4300_squashfs-3.0.patch.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org/"
KEYWORDS="-* hppa"

src_unpack() {

	if [[ -n ${KV_EXTRA} ]]
	then

		KV_EXTRA=".${KV_EXTRA}"

		zcat ${DISTDIR}/patch-${OKV}-pa${PATCH_LEVEL}.gz | \
			sed -e "/+EXTRAVERSION/s/=.*\$/=/" > \
			${T}/patch-${OKV}-pa${PATCH_LEVEL}.patch
	else
		zcat ${DISTDIR}/patch-${OKV}-pa${PATCH_LEVEL}.gz > \
			${T}/patch-${OKV}-pa${PATCH_LEVEL}.patch
	fi

	EXTRAVERSION=${KV_EXTRA}-pa${PATCH_LEVEL}

	universal_unpack

	# We force the order of patching. kernel-2.eclass does weird stuff
	unipatch  ${UNIPATCH_LIST}
	unipatch  ${UNIPATCH_LIST_DEFAULT}

	unpack_set_extraversion
	unpack_fix_install_path
}
