# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/xtail/xtail-2.1.ebuild,v 1.9 2002/11/30 02:05:37 vapier Exp $

DESCRIPTION="Tail multiple logfiles at once, even if rotated."
SRC_URI="http://www.unicom.com/sw/xtail/${P}.tar.gz"
HOMEPAGE="http://www.unicom.com/sw/xtail/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	econf
	emake || die
}

src_install() {
	doman xtail.1
	dobin xtail
	dodoc README
}
