# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.4-r1.ebuild,v 1.6 2001/01/27 14:41:34 achim Exp $

P=automake-1.4      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Used to generate Makefile.in from Makefile.am"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/automake/${A}
	 ftp://prep.ai.mit.edu/gnu/automake/${A}"
HOMEPAGE="http://www.gnu.org/software/automake/automake.html"
DEPEND=">=sys-devel/perl-5.6"
RDEPEND=">=sys-apps/bash-2.04
	 >=sys-devel/perl-5.6"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {   
    try make prefix=${D}/usr install                            
    dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog
}


