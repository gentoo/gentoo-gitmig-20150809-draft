# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/foremost/foremost-1.5.ebuild,v 1.1 2007/05/17 16:57:23 hyakuhei Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A console program to recover files based on their headers and footers"
HOMEPAGE="http://foremost.sourceforge.net/"
SRC_URI="http://foremost.sourceforge.net/pkg/${P}.tar.gz"

KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""
LICENSE="public-domain"
SLOT="0"

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
}

src_compile() {
	emake RAW_FLAGS="${CFLAGS} -Wall" RAW_CC="$(tc-getCC) -DVERSION=\\\"${PV}\\\"" \
		CONF=/etc || die "emake failed"
}

src_install() {
	dobin foremost
	doman foremost.1
	insinto /etc
	doins foremost.conf
	dodoc README CHANGES
}
