# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Ben Lutgens <blutgens@sistina.com> 
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.3.1.ebuild,v 1.1 2002/04/05 22:02:45 seemant Exp $

S=${WORKDIR}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://prdownloads.sourceforge.net/cdrx/${P}.tar.gz"
HOMEPAGE="http://cdrx.sourceforge.net/"
SLOT="0"
DEPEND=">=app-cdr/cdrtools-1.11 sys-devel/perl"

src_install () {
	
	dobin cdrx.pl
	dodoc README.txt TODO
	dohtml -r ./
}
