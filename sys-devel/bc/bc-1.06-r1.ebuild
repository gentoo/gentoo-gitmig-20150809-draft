# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bc/bc-1.06-r1.ebuild,v 1.2 2001/03/06 05:27:28 achim Exp $
      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Handy console-based calculator utility"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/bc/${A}
 	 ftp://prep.ai.mit.edu/pub/gnu/bc/${A}"
HOMEPAGE="http://www.gnu.org/software/bc/bc.html"

DEPEND="virtual/glibc
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )"

src_compile() {

        local myconf
        if [ "`use readline`" ]
        then
          myconf="--with-readline"
        fi
	try ./configure ${myconf} --host=${CHOST} --prefix=/usr
	try make ${MAKEOPTS}

}

src_install() {

	into /usr
	doinfo doc/*.info
	dobin bc/bc dc/dc
	doman doc/*.1
	dodoc AUTHORS COPYING* FAQ NEWS README ChangeLog

}


