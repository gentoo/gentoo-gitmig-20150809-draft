# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.10.35-r1.ebuild,v 1.2 2001/01/31 20:49:07 achim Exp $

P=gettext-0.10.35      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU locale utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gettext/${A}
	 ftp://prep.ai.mit.edu/gnu/gettext/${A}"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"

DEPEND="virtual/glibc
        || ( sys-devel/bison sys-build/bison )"

RDEPEND="virtual/glibc
        || ( sys-apps/bash sys-build/bash )"

src_compile() {                           
	try ./configure --prefix=/usr --with-included-gettext --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {                               
	cd ${S}
	try make prefix=${D}/usr lispdir=${D}/usr/share/emacs/site-lisp install
	dodoc AUTHORS BUGS COPYING ChangeLog DISCLAIM NEWS README* THANKS TODO
	exeopts -m0755
	exeinto /usr/bin
	doexe misc/gettextize
}


