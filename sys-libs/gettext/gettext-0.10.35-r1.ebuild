# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gettext/gettext-0.10.35-r1.ebuild,v 1.3 2000/08/27 23:55:15 achim Exp $

P=gettext-0.10.35      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU locale utilities"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gettext/${A}"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"

src_compile() {                           
	./configure --prefix=/usr --with-included-gettext --host=${CHOST}
	make
}

src_install() {                               
	cd ${S}
	make prefix=${D}/usr lispdir=${D}/usr/share/emacs/site-lisp install
	prepinfo
	dodoc AUTHORS BUGS COPYING ChangeLog DISCLAIM NEWS README README-alpha THANKS TODO
	exeopts -m0755
	exeinto /usr/bin
	doexe misc/gettextize
}


