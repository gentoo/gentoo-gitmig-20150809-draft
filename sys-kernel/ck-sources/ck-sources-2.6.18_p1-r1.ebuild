# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.18_p1-r1.ebuild,v 1.1 2006/10/17 22:01:13 marineam Exp $

DESCRIPTION="Full sources for the Linux kernel with Con Kolivas' high performance patchset and Gentoo's basic patchset."
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
IUSE="ck-server"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

K_NOUSENAME="yes"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="2"
ETYPE="sources"
inherit kernel-2

detect_version
# A few hacks to set ck version via _p instead of -r
MY_PR=${PR/r/-r}
MY_PR=${MY_PR/-r0/}
EXTRAVERSION=-ck${PV/*_p/}${MY_PR}
KV_FULL=${OKV}${EXTRAVERSION}
KV_CK=${KV_FULL/-r*/}

if use ck-server; then
	UNIPATCH_LIST="${DISTDIR}/patch-${KV_CK/ck/cks}.bz2"
else
	UNIPATCH_LIST="${DISTDIR}/patch-${KV_CK}.bz2"
fi

# Custom 2.6.18.1 patch that fixes a reject, here for 2.6.18 cycle only.
UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/patch-2.6.18.1-ck1.bz2"

# Note: 2.6.x.y updates in genpatches begin with 10 but are included in -ck
# new order of patches means some additional excludes.
UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1000"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI}
	ck-server? (
	mirror://kernel/linux/kernel/people/ck/patches/cks/patch-${KV_CK/ck/cks}.bz2
	)
	!ck-server? (
	mirror://kernel/linux/kernel/people/ck/patches/2.6/${OKV}/${KV_CK}/patch-${KV_CK}.bz2 )
	mirror://gentoo/patch-2.6.18.1-ck1.bz2"


pkg_postinst() {
	postinst_sources

	einfo "The ck patchset is tuned for desktop usage."
	einfo "To better tune the kernel for server applications add"
	einfo "ck-server to your use flags and reemerge ck-sources"
}
