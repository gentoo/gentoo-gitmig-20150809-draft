# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/gimp-print-cups/gimp-print-cups-4.2.0-r1.ebuild,v 1.2 2002/07/14 20:41:22 aliz Exp $

DESCRIPTION="The Common Unix Printing System - Gimp Print Drivers"
HOMEPAGE="http://www.cups.org"
KEYWORDS="x86"
SRC_URI="http://download.sourceforge.net/gimp-print/${P/-cups/}.tar.gz"

S=${WORKDIR}/${P/-cups/}
DEPEND="net-print/cups 
	media-gfx/imagemagick
	sys-libs/readline
	sys-devel/perl"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--infodir=/usr/share/info \
		--with-cups \
		--enable-test \
		--with-samples \
		--without-gimp \
		--with-escputil \
		--without-foomatic \
		--with-testpattern \
		--without-user-guide \
		--host=${CHOST} || die "bad ./configure"

	emake || die "compile problem"
}

src_install () {
	make install DESTDIR=${D} || die

	exeinto /usr/share/gimp-print
	doexe test/{unprint,pcl-unprint,bjc-unprint,parse-escp2,parse-bjc}

	dodoc AUTHORS COPYING ChangeLog NEWS README \
		 doc/gimpprint.ps
	dohtml doc/manual-html doc/FAQ.html
}
