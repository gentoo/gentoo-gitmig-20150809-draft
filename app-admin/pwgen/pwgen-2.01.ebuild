# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.01.ebuild,v 1.5 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Password Generator"
SRC_URI="mirror://sourceforge/pwgen/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"
LICENSE="GPL-2"

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
