# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.12_p2.ebuild,v 1.1 2005/06/22 17:41:21 marineam Exp $

K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2 eutils
detect_version

# A few hacks to set ck version via _p instead of -r
MY_P=${P/_p*/}
MY_PR=${PR/r/-r}
MY_PR=${MY_PR/-r0/}
EXTRAVERSION=-ck${PV/*_p/}${MY_PR}
KV_FULL=${OKV}${EXTRAVERSION}
KV_CK=${KV_FULL/-r*/}

IUSE="ck-server"
if use ck-server; then
	CK_PATCH="patch-${KV_CK}-server.bz2"
else
	CK_PATCH="patch-${KV_CK}.bz2"
fi

#version of gentoo patchset
GPV="12-1"
GPV_VESAFB="4505_vesafb-tng-0.9-rc6-r2.patch"
GPV_INOTIFY="4800_inotify-0.23-12.patch"
GPV_BASE="genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.base.tar.bz2"
GPV_EXTRA="genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.extras.tar.bz2"
GPV_SRC="mirror://gentoo/${GPV_BASE} mirror://gentoo/${GPV_EXTRA}"

UNIPATCH_LIST="
	${DISTDIR}/${CK_PATCH}
	${DISTDIR}/${GPV_BASE}"

UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
	10" #All of the 2.6.x.y patches (already in ck) start with 10

UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}/0000_README"

DESCRIPTION="Full sources for the Stock Linux kernel and Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI} ${GPV_SRC}
	ck-server? ( http://ck.kolivas.org/patches/2.6/${OKV}/${KV_CK}/patch-${KV_CK}-server.bz2 )
	!ck-server? ( http://ck.kolivas.org/patches/2.6/${OKV}/${KV_CK}/patch-${KV_CK}.bz2 )"

KEYWORDS="~x86 ~amd64"

src_unpack() {
	kernel-2_src_unpack

	cd ${WORKDIR}
	unpack ${GPV_EXTRA}

	cd ${S}
	epatch ${WORKDIR}/${OKV}/${GPV_VESAFB}
	epatch ${WORKDIR}/${OKV}/${GPV_INOTIFY}
}

# Left out for now because ck-sources isn't keyworded for sparc
# (from gentoo-sources)
#pkg_setup() {
#	if use sparc; then
#		# hme lockup hack on ultra1
#		use ultra1 || UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1399_sparc-U1-hme-lockup.patch"
#	fi
#}

pkg_postinst() {
	postinst_sources

	einfo "The ck patchset is tuned for desktop usage."
	einfo "To better tune the kernel for server applications add"
	einfo "ck-server to your use flags and reemerge ck-sources"
}

