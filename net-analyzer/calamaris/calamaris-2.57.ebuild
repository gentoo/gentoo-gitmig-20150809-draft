# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/calamaris/calamaris-2.57.ebuild,v 1.3 2003/07/13 11:30:10 aliz Exp $

DESCRIPTION="Calamaris parses the logfiles of a wide variety of Web proxy servers and generates reports"
HOMEPAGE="http://calamaris.cord.de/"
SRC_URI="http://calamaris.cord.de/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
DEPEND="dev-lang/perl"
RDEPEND="dev-lang/perl"
S=${WORKDIR}/${P}

src_install () {
	dobin calamaris
	doman calamaris.1
	dodoc CHANGES EXAMPLES README
}
