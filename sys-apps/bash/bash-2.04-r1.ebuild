# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bash/bash-2.04-r1.ebuild,v 1.2 2000/12/13 17:20:36 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/bash/${A}
	 ftp://ftp.gnu.org/gnu/bash/${A}"

HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

src_compile() {                           

	cd ${S}
	try ./configure --prefix=/  --host=${CHOST} \
		--disable-profiling --with-curses \
		--enable-static-link --with-installed-readline
	cp Makefile Makefile.orig
	sed -e "s:-lcurses:-lncurses:" Makefile.orig > Makefile	
	try pmake
	if [ "`use tex`" ]
	then
	  cd support
	  cp texi2html texi2html.orig
	  sed -e "s:/usr/local/bin/perl:/usr/bin/perl:" \
	   texi2html.orig > texi2html
	  cd ../doc
	  try make
	fi

}



src_install() {    
	cd ${S}
	if [ "`use tex`" ]
        then
	  docinto html
	  dodoc doc/*.html
	  docinto ps
	  dodoc doc/*.ps
	fi
	make prefix=${D}/usr install
	dodir /bin
	mv ${D}/usr/bin/bash ${D}/bin
	dosym bash /bin/sh
	doman doc/builtins.1 bash_builtins.1
	dodoc README NEWS AUTHORS CHANGES COMPAT COPYING Y2K 
	dodoc doc/FAQ doc/INTRO
}

