# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@sistina.com> 
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.2.1.1.ebuild,v 1.1 2001/08/28 18:15:19 danarmak Exp $

P=cdrx-0.2.1p1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://cdrx.sourceforge.net/${A}"
HOMEPAGE="http://cdrx.sourceforge.net/"

DEPEND=">=app-cdr/cdrecord-1.9 sys-devel/perl"

src_unpack() {

    mkdir ${P}
    cd ${P}
    unpack ${A}

}

src_install () {

	dobin cdrx.pl
	dodoc README.txt TODO
	docinto html
	dodoc help.html

}

