# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unarj/unarj-2.63a-r1.ebuild,v 1.5 2003/11/25 03:38:17 agriffis Exp $

DESCRIPTION="Utility for opening arj archives."
HOMEPAGE="http://ibiblio.org/pub/Linux/utils/compress/"
SRC_URI="http://ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"

SLOT="0"
LICENSE="arj"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=sys-apps/baselayout-1.8.0"

src_compile() {
	emake || die
}

src_install() {
	dobin unarj
	dodoc unarj.txt technote.txt readme.txt
}
