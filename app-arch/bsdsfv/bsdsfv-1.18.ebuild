# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.18.ebuild,v 1.7 2005/01/01 11:41:36 eradicator Exp $

DESCRIPTION="all-in-one SFV checksum utility"
HOMEPAGE="http://bsdsfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/bsdsfv/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc arm"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
}

src_install() {
	dobin bsdsfv || die
	dodoc README MANUAL
}
