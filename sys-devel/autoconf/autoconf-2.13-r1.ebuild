# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.13-r1.ebuild,v 1.6 2001/01/27 14:41:34 achim Exp $

P=autoconf-2.13      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Used to create autoconfiguration files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/autoconf/${A}
	 ftp://prep.ai.mit.edu/gnu/autoconf/${A}"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"
DEPEND=">=sys-devel/perl-5.6"
RDEPEND=">=sys-apps/bash-2.04
	 >=sys-devel/perl-5.6"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {    
    try make prefix=${D}/usr install                           
    dodoc COPYING AUTHORS ChangeLog.* NEWS README TODO
}


