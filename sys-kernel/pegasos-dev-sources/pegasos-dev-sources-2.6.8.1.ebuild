# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pegasos-dev-sources/pegasos-dev-sources-2.6.8.1.ebuild,v 1.1 2004/08/16 00:56:36 dholm Exp $

ETYPE="sources"
inherit kernel-2
detect_version

# Version of gentoo patchset
GPV=8.1.0
GPV_SRC="mirror://gentoo/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"

KEYWORDS="ppc"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README
	${WORKDIR}/patches/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/pegasos-config"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree on Pegasos computers"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following option:"
	ewarn "    Device Drivers -> Character devices -> Legacy (BSD) PTY Support."
	echo
	ewarn "Bootsplash is missing from this release."
	echo
}
