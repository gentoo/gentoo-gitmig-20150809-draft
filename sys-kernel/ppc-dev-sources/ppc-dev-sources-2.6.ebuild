# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-dev-sources/ppc-dev-sources-2.6.ebuild,v 1.4 2004/07/15 05:22:21 agriffis Exp $

DESCRIPTION="Dummy ebuild pointing the user to gentoo-dev-sources as 2.6 kernel (incl pegasos)"
LICENSE="GPL-2"

KEYWORDS="-* ppc"
IUSE=""
SRC_URI=""
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/benh/"
SLOT="2.6"
DEPEND=""
RDEPEND=""


src_unpack() {
	echo
	ewarn "Benjamin Herrenschmidt (benh), the upstream ppc kernel maintainer, has merged his 2.6 tree"
	ewarn "with linus' tree. This means a separate ppc 2.6 kernel sources ebuild is no longer necessary"
	ewarn ""
	ewarn "Please use one of following kernels:"
	ewarn " - gentoo-dev-sources  (2.6 vanilla + performance enhancing patches + pegasos support"
	ewarn " - development-sources (2.6 vanilla - no pegasos support)"
	die
}
