# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Damon Conway <kabau@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.01.ebuild,v 1.1 2002/01/04 15:36:56 kabau Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Password Generator"
SRC_URI="http://prdownloads.sourceforge.net/pwgen/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"

DEPEND="virtual/glibc"

src_compile() {
	# Fix the Makefile
	cp Makefile.in Makefile.in.new
	sed -e 's:$(prefix)/man/man1:$(mandir)/man1:g' Makefile.in.new > Makefile.in

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/pwgen || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
