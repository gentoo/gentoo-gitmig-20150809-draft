# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/guile/guile-1.5.4.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Guile is an interpreter for Scheme"
SRC_URI="ftp://alpha.gnu.org/gnu/guile/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/guile/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
        >=sys-libs/readline-4.1"


src_unpack() {

	unpack ${A}
	cd ${S}
#	cp  ${FILESDIR}/net_db.c libguile/
}

src_compile() {

	./configure --prefix=/usr					\
		    --infodir=/usr/share/info				\
		    --with-threads					\
		    --with-modules || die

	emake || die
}

src_install() {

	make prefix=${D}/usr						\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc AUTHORS COPYING ChangeLog GUILE-VERSION HACKING NEWS 
	dodoc README SNAPSHOTS THANKS
}
