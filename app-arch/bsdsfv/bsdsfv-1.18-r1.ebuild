# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.18-r1.ebuild,v 1.1 2005/09/19 17:53:01 flameeyes Exp $

inherit eutils flag-o-matic

DESCRIPTION="all-in-one SFV checksum utility"
HOMEPAGE="http://bsdsfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/bsdsfv/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc-macos ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-64bit.patch"
}

src_compile() {
	emake STRIP=true CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dobin bsdsfv || die
	dodoc README MANUAL
}
