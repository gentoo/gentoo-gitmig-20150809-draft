# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ren/ren-1.0.ebuild,v 1.2 2002/07/14 19:20:19 aliz Exp $

DESCRIPTION="Renames multiple files"
HOMEPAGE="http://freshmeat.net/projects/ren"
KEYWORDS="x86"
SLOT="0"
LICENSE=""

SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/${P}.tar.gz"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	dobin ren
	dodoc README 
	doman ren.1
}
