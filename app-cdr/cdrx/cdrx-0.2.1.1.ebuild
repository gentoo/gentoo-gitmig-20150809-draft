# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@sistina.com> 
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.2.1.1.ebuild,v 1.3 2001/11/10 02:36:20 hallski Exp $

P=cdrx-0.2.1p1
S=${WORKDIR}/${P}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://cdrx.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://cdrx.sourceforge.net/"

DEPEND=">=app-cdr/cdrtools-1.11 sys-devel/perl"

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

