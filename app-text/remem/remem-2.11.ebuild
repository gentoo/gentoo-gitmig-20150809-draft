# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/remem/remem-2.11.ebuild,v 1.8 2003/02/13 09:44:08 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="MIT's Remembrance Agent"
SRC_URI="http://rhodes.www.media.mit.edu/people/rhodes/RA/${P}.tar.gz"
HOMEPAGE="http://rhodes.www.media.mit.edu/people/rhodes/RA/"
KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="GPL-2"
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
