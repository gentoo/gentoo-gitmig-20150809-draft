# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/development-sources/development-sources-2.6.5_rc3.ebuild,v 1.1 2004/03/30 17:24:29 spock Exp $

K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the vanilla 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="${KERNEL_URI}"

KEYWORDS="~x86"

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following option:"
	ewarn "    Device Drivers -> Character devices -> Legacy (BSD) PTY Support."
	echo
}
