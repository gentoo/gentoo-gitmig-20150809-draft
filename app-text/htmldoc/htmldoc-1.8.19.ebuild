# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Enrico Morelli  <emorelli@gentoo.it>
# $Header: /var/cvsroot/gentoo-x86/app-text/htmldoc/htmldoc-1.8.19.ebuild,v 1.1 2002/06/01 08:20:58 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Convert HTML pages into a PDF document"
SRC_URI="ftp://ftp.funet.fi/pub/mirrors/ftp.easysw.com/pub/htmldoc/1.8.19/${P}-source.tar.bz2"
HOMEPAGE="http://www.easysw.com/htmldoc"
DEPEND="virtual/x11"
RDEPEND=">=x11-libs/fltk-1.0.11"

src_unpack() {
	
	unpack ${A} ; cd ${S}
		
}

	
src_compile() {
	./configure  \
		--with-x \
		--with-gui || die
		
	make || die
}


src_install() {
	into /usr
	doman doc/*.1
	dobin htmldoc/htmldoc
	insinto /usr/share/htmldoc/afm
	doins afm/*
	insinto /usr/share/htmldoc/data
	doins data/*
}
