# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.3.1-r1.ebuild,v 1.4 2004/06/06 14:53:36 dragonheart Exp $

MY_P="${PN}-${PV}p1"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="mirror://sourceforge/cdrx/${MY_P}.tar.gz"
HOMEPAGE="http://cdrx.sourceforge.net/"

SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"

DEPEND=">=app-cdr/cdrtools-1.11
	dev-lang/perl"

src_install() {
	dobin cdrx.pl
	dodoc README.txt TODO
	dohtml -r ./
}
