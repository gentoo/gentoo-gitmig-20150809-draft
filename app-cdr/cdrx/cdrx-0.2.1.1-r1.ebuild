# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Ben Lutgens <blutgens@sistina.com> 
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.2.1.1-r1.ebuild,v 1.1 2002/03/27 11:56:38 seemant Exp $

MY_P=${PN}-0.2.1p1
S=${WORKDIR}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://cdrx.sourceforge.net/${MY_P}.tar.gz"
HOMEPAGE="http://cdrx.sourceforge.net/"
SLOT="0"
DEPEND=">=app-cdr/cdrtools-1.11 sys-devel/perl"

src_install () {
	
	dobin cdrx.pl
	dodoc README.txt TODO
	dohtml -r ./
}
