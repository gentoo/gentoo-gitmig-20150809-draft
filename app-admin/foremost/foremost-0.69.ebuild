# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/foremost/foremost-0.69.ebuild,v 1.5 2004/06/25 23:22:37 vapier Exp $

DESCRIPTION="A console program to recover files based on their headers and footers"
HOMEPAGE="http://foremost.sourceforge.net/"
SRC_URI="http://foremost.sourceforge.net/pkg/${P}.tar.gz"

KEYWORDS="~x86 ~ppc"
IUSE=""
LICENSE="public-domain"
SLOT="0"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:^CC_OPTS = .*$:CC_OPTS = ${CFLAGS}:" Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin foremost || die "dobin failed"
	doman foremost.1
	dodoc foremost.conf README CHANGES TODO
}
