# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bc/bc-1.05a-r1.ebuild,v 1.3 2000/09/15 20:09:25 drobbins Exp $

P=bc-1.05a      
A=${P}.tar.gz
S=${WORKDIR}/bc-1.05
DESCRIPTION="Handy console-based calculator utility"
SRC_URI="ftp://ftp.gnu.ai.mit.edu/pub/gnu/bc/${A}"
HOMEPAGE="http://www.gnu.org/software/bc/bc.html"

src_compile() {                           
	try ./configure --with-readline --host=${CHOST} --prefix=/usr
	try make 
}

src_install() {                    
	into /usr
	doinfo doc/dc.info
	dobin bc/bc dc/dc
	doman doc/*.1
	dodoc AUTHORS COPYING NEWS README ChangeLog
}


