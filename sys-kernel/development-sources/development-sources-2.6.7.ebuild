# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/development-sources/development-sources-2.6.7.ebuild,v 1.8 2004/07/27 08:14:43 spock Exp $

K_NOUSENAME="yes"
ETYPE="sources"
SPARC_URI="mirror://gentoo/patches-2.6.7-sparc.tar.bz2"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Full sources for the vanilla 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="${KERNEL_URI} ${ARCH_URI}"
UNIPATCH_LIST="${ARCH_PATCH}"

IUSE="ultra1"
use ultra1 || UNIPATCH_EXCLUDE="99_U1-hme-lockup"

KEYWORDS="x86 ~sparc ppc ~amd64 ~alpha"

pkg_postinst() {
	postinst_sources

	if [ "${ARCH}" = "sparc" ]; then
		if [ x"`cat /proc/openprom/name 2>/dev/null`" \
			 = x"'SUNW,Ultra-1'" ]; then
			einfo "For users with an Enterprise model Ultra 1 using the HME"
			einfo "network interface, please emerge the kernel using the"
			einfo "following command: USE=ultra1 emerge ${PN}"
		fi
	fi
}
