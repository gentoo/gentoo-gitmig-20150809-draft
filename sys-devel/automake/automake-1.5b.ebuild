# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.5b.ebuild,v 1.2 2002/04/07 13:46:10 gbevin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Used to generate Makefile.in from Makefile.am"
SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/automake/automake.html"

DEPEND="sys-devel/perl"

SLOT="1.5"

src_compile() {

	./configure --prefix=/usr \
    		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} || die
		
	make ${MAKEOPTS} || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog
}
