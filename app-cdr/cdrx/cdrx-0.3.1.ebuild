# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.3.1.ebuild,v 1.10 2003/03/11 21:11:44 seemant Exp $

DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="mirror://sourceforge/cdrx/${P}.tar.gz"
HOMEPAGE="http://cdrx.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2"

DEPEND=">=app-cdr/cdrtools-1.11
	dev-lang/perl"

S=${WORKDIR}

src_install() {
	dobin cdrx.pl
	dodoc README.txt TODO
	dohtml -r ./
}
