# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.16.52.ebuild,v 1.1 2007/07/10 19:42:31 marineam Exp $

ETYPE="sources"
UNIPATCH_STRICTORDER="1"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://www.xensource.com/xen/xen/"

XEN_VERSION="3.0.4_1"
XEN_BASE_KV="2.6.16.33"
XEN_PATCH="patch-${XEN_BASE_KV}_to_xen-${XEN_VERSION}.bz2"
PATCH_URI="mirror://gentoo/${XEN_PATCH}"
SRC_URI="${KERNEL_URI} ${PATCH_URI}"

UNIPATCH_LIST="${DISTDIR}/${XEN_PATCH}
	${FILESDIR}/${P}-ipt-reject-fix.patch"

KEYWORDS="~x86 ~amd64"

pkg_postinst() {
	postinst_sources

	elog "This kernel uses the linux patches released with Xen 3.0.4"
	elog "It claims to have a 3.0.2 compatibility option but it may not work."
}
