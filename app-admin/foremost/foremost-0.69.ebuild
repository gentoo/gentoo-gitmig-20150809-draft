# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/foremost/foremost-0.69.ebuild,v 1.1 2004/04/27 16:08:16 mholzer Exp $

DESCRIPTION="A console program to recover files based on their headers and footers"
SRC_URI="http://foremost.sourceforge.net/pkg/${P}.tar.gz"
HOMEPAGE="http://foremost.sourceforge.net/"

KEYWORDS="~x86"
LICENSE="public-domain"
SLOT="0"

DEPEND="virtual/glibc"

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
