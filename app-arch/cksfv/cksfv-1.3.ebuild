# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.ebuild,v 1.8 2003/09/20 20:33:54 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="cksfv: SFV checksum utility (simple file verification)"
SRC_URI="http://www.fodder.org/cksfv/${P}.tar.gz"
HOMEPAGE="http://www.fodder.org/cksfv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	dobin src/cksfv
	dodoc COPYING ChangeLog INSTALL README TODO
}
