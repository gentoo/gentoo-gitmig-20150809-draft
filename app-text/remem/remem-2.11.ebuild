# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Chouser <chouser@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/remem/remem-2.11.ebuild,v 1.1 2002/01/13 23:12:19 chouser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="MIT's Remembrance Agent"
SRC_URI="http://rhodes.www.media.mit.edu/people/rhodes/RA/${P}.tar.gz"
HOMEPAGE="http://rhodes.www.media.mit.edu/people/rhodes/RA/"
DEPEND=""

src_compile() {
	lispdir=/usr/share/emacs/site-lisp \
		./configure --host=${CHOST} --prefix=/usr || die "./configure failed"
	make || die "make failed" # emake caused weirdness
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
