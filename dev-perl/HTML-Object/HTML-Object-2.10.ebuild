# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Object/HTML-Object-2.10.ebuild,v 1.1 2001/09/25 19:02:24 achim Exp $

P=html_object-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://prdownloads.sourceforge.net/htmlobject/${A}"
HOMEPAGE="http://htmlobject.sourceforge.net"
DEPEND=">=sys-devel/perl-5"

src_compile() {

    perl Makefile.PL
    try make 

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes LICENSE MANIFEST README TODO 

}
