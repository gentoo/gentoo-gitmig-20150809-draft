# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/safestr/safestr-1.0.2.ebuild,v 1.5 2004/07/14 15:06:31 agriffis Exp $

DESCRIPTION="provide a standards compatible yet secure string implementation"
HOMEPAGE="http://www.zork.org/safestr/"
SRC_URI="http://www.zork.org/software/${P}.tar.gz"

LICENSE="ZORK"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/xxl"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf xxl-1.0.0
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc README doc/safestr.pdf
	dohtml doc/safestr.html
}
