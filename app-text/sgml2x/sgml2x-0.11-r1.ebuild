# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml2x/sgml2x-0.11-r1.ebuild,v 1.18 2004/02/22 20:06:50 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Frontend for jade and jadetex"
SRC_URI="ftp://sgml2x.sourceforge.net/pub/sgml2x/${P}.tar.gz"
HOMEPAGE="http://sgml2x.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND=">=dev-lang/perl-5"

src_compile() {
	make || die
}

src_install() {
	dodir /usr/bin
	dodir /etc
	make PREFIX=${D}/usr prefix=${D}/usr sysconfdir=${D}/etc install
	echo <<END > ${D}/sgml2x.conf
# Path to dsssl-stylesheets
stylepath=/usr/share/sgml/docbook/dsssl-stylesheets-1.64
END
	dodoc README
	dohtml -r doc
}
