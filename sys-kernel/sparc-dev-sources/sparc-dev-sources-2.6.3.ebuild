# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sparc-dev-sources/sparc-dev-sources-2.6.3.ebuild,v 1.1 2004/02/20 04:14:35 wesolows Exp $

IUSE="ultra1"

ETYPE="sources"
SPARC_URI="mirror://gentoo/patches-2.6.3-sparc.tar.bz2"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Full sources for the vanilla 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="${KERNEL_URI} ${ARCH_URI}"
UNIPATCH_LIST="${ARCH_PATCH}"

use ultra1 || UNIPATCH_EXCLUDE="99_U1-hme-lockup"

KEYWORDS="~x86 ~amd64 ~sparc"

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following options"
	ewarn "    Device Drivers -> Character devices  -> Unix98 PTY Support"
	ewarn "    File systems   -> Pseudo filesystems -> /dev/pts filesystem."
	echo

	if [ x"`cat /proc/openprom/name 2>/dev/null`" = x"'SUNW,Ultra-1'" ]; then
			einfo "For users with an Enterprise model Ultra 1 using the HME"
			einfo "network interface, please emerge the kernel using the"
			einfo "following command: USE=ultra1 emerge ${PN}"
			echo
	fi

	ewarn "${PN} is DEPRECATED.  2.6.3 will be the last release.  Instead,"
	ewarn "please use development-sources.  It includes the same"
	ewarn "functionality as ${PN} when installed on a sparc system."
	echo
}
