# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/safestr/safestr-1.0.2.ebuild,v 1.2 2004/03/14 12:28:58 mr_bones_ Exp $

DESCRIPTION="provide a standards compatible yet secure string implementation"
HOMEPAGE="http://www.zork.org/safestr/"
SRC_URI="http://www.zork.org/software/${P}.tar.gz"

LICENSE="ZORK"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
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
