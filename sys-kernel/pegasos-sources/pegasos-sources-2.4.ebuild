# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pegasos-sources/pegasos-sources-2.4.ebuild,v 1.1 2004/08/13 08:58:50 dholm Exp $

DESCRIPTION="Dummy ebuild pointing the user to gentoo-dev-sources or pegasos-dev-sources as 2.6 kernel"
LICENSE="GPL-2"

KEYWORDS="-* ppc"
IUSE=""
SRC_URI=""
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/benh/"
SLOT="2.4"
DEPEND=""
RDEPEND=""


src_unpack() {
	echo
	ewarn "Kernel 2.4 has been deprecated as all PowerPC development has moved to the"
	ewarn "2.6 kernel tree."
	ewarn ""
	ewarn "Please use one of following kernels:"
	ewarn " - gentoo-dev-sources  (2.6 vanilla + performance enhancing patches + pegasos support"
	ewarn " - pegasos-dev-sources (2.6 vanilla + lots of features + pegasos support)"
	die
}
