# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml2x/sgml2x-0.11-r1.ebuild,v 1.9 2002/04/27 09:32:57 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Frontend for jade and jadetex"
SRC_URI="ftp://sgml2x.sourceforge.net/pub/sgml2x/${P}.tar.gz"
HOMEPAGE="http://sgml2x.sourceforge.net/"

DEPEND=">=sys-devel/perl-5"
SLOT="0"

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
