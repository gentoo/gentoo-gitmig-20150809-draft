# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.3_rc2.ebuild,v 1.2 2004/02/10 15:58:44 brad_mssw Exp $

#version of gentoo patchset
GPV=2.19
GPV_SRC="mirror://gentoo/genpatches-2.6-${GPV}.tar.bz2"

KEYWORDS="~amd64 ~x86"

UNIPATCH_LIST="${DISTDIR}/genpatches-2.6-${GPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/README"

ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following options"
	ewarn "    Device Drivers -> Character devices  -> Unix98 PTY Support"
	ewarn "    File systems   -> Pseudo filesystems -> /dev/pts filesystem."
	echo
	ewarn "If you choose to use UCL/gcloop please ensure you also"
	ewarn "emerge ucl as well as it currently depends on this library."
	ewarn "Also please ensure that you compile gcloop without -fstack-protector."
	echo
}
