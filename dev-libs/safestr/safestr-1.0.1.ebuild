# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/safestr/safestr-1.0.1.ebuild,v 1.1 2003/10/08 18:36:18 vapier Exp $

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
	epatch ${FILESDIR}/${PV}-makefile.patch
	rm -rf xxl-1.0.0
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc README
	dohtml doc/safestr.html
}
