# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/calamaris/calamaris-2.57.ebuild,v 1.7 2005/04/03 01:00:12 vanquirius Exp $

DESCRIPTION="Calamaris parses the logfiles of a wide variety of Web proxy servers and generates reports"
HOMEPAGE="http://calamaris.cord.de/"
SRC_URI="http://calamaris.cord.de/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
DEPEND="dev-lang/perl"
RDEPEND="dev-lang/perl"
IUSE=""

src_install () {
	dobin calamaris
	doman calamaris.1
	dodoc CHANGES EXAMPLES README
}
