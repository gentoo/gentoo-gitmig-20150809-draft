# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.18.ebuild,v 1.1 2003/11/10 14:41:11 vapier Exp $

DESCRIPTION="BSDSFV: All-in-one SFV checksum utility"
HOMEPAGE="http://bsdsfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/bsdsfv/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
}

src_install() {
	dobin bsdsfv
	dodoc README MANUAL
}
