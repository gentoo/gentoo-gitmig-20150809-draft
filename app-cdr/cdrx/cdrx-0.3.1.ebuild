# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.3.1.ebuild,v 1.6 2002/07/22 01:39:12 lostlogic Exp $

S=${WORKDIR}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="mirror://sourceforge/cdrx/${P}.tar.gz"
HOMEPAGE="http://cdrx.sourceforge.net/"
SLOT="0"
DEPEND=">=app-cdr/cdrtools-1.11 sys-devel/perl"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_install () {
	
	dobin cdrx.pl
	dodoc README.txt TODO
	dohtml -r ./
}
