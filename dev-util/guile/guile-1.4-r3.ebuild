# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/guile/guile-1.4-r3.ebuild,v 1.2 2001/11/10 12:45:09 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Guile is an interpreter for Scheme"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/guile/${P}.tar.gz
	 ftp://prep.ai.mit.edu/gnu/guile/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/guile/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
        >=sys-libs/readline-4.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp  ${FILESDIR}/net_db.c libguile/
}

src_compile() {                           
	cd ${S}
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --infodir=/usr/share/info				\
		    --with-threads					\
		    --with-modules
	assert

	make || die
}

src_install() {
	make prefix=${D}/usr						\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc AUTHORS COPYING ChangeLog GUILE-VERSION HACKING NEWS 
	dodoc README SNAPSHOTS THANKS
}
