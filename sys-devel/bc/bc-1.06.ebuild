# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bc/bc-1.06.ebuild,v 1.2 2000/11/30 23:15:06 achim Exp $
      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Handy console-based calculator utility"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/bc/${A}
 	 ftp://prep.ai.mit.edu/pub/gnu/bc/${A}"
HOMEPAGE="http://www.gnu.org/software/bc/bc.html"
DEPEND=">=sys-libs/gpm-1.19.3
	>=sys-libs/readline-4.1"

src_compile() {                           
	try ./configure --with-readline --host=${CHOST} --prefix=/usr
	try make ${MAKEOPTS}
}

src_install() {                    
	into /usr
	doinfo doc/*.info
	dobin bc/bc dc/dc
	doman doc/*.1
	dodoc AUTHORS COPYING* FAQ NEWS README ChangeLog
}


