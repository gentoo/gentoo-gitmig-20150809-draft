# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-dev-sources/hardened-dev-sources-2.6.7-r15.ebuild,v 1.2 2004/11/24 20:18:49 method Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2
detect_version

GPV=7.46
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2"

HGPV=7.8
#HGPV_SRC="mirror://gentoo/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"
HGPV_SRC="http://dev.gentoo.org/~tseng/kernel/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2
		  http://tocharian.ath.cx/hardened/hardened-dev-sources-r15/hardened-dev-sources-2.6.7-CAN-2004-0814.patch"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_EXCLUDE="1315_alpha"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2
		       ${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
			   ${FILESDIR}/hardened-dev-sources-2.6.7.CAN-2004-0816.patch
			   ${FILESDIR}/h-d-s-2.6.7-amd64-kill-vm_force_exec32.patch
			   ${FILESDIR}/hardened-2.6.7-binfmt_elf.patch
			   ${FILESDIR}/hardened-2.6.7-binfmt_aout.patch
			   ${FILESDIR}/hardened-dev-sources-2.6.7-ptmx.patch
			   ${DISTDIR}/hardened-dev-sources-2.6.7-CAN-2004-0814.patch
			   ${FILESDIR}/hardened-dev-sources-2.6.7-CAN-2004-0883.patch"
UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC} ${GPV_SRC}"
KEYWORDS="x86 ~ppc amd64"

pkg_postinst() {
	postinst_sources
}
