# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.3_rc3.ebuild,v 1.3 2004/02/17 02:51:17 brad_mssw Exp $

ETYPE="sources"
inherit kernel-2
detect_version

#version of gentoo patchset
#3.22 is next :)
GPV=2.20
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"

KEYWORDS="~amd64 ~x86"

UNIPATCH_LIST="${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/README"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"

DEPEND="${DEPEND} >=dev-libs/ucl-1"

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following options"
	ewarn "    Device Drivers -> Character devices  -> Unix98 PTY Support"
	ewarn "    File systems   -> Pseudo filesystems -> /dev/pts filesystem."
	echo
	ewarn "If you choose to use UCL/gcloop please ensure you compile gcloop"
	ewarn "without -fstack-protector."
	echo
}
