# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/swish-e/swish-e-2.2.2.ebuild,v 1.2 2003/07/13 21:44:10 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Simple Web Indexing System for Humans - Ehanced"
SRC_URI="http://www.swish-e.org/Download/${P}.tar.gz"
HOMEPAGE="http://www.swish-e.org"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-libs/zlib-1.1.3
	 dev-libs/libxml2
	dev-perl/libwww-perl"
	
src_compile() {

	econf || die

	emake || die

}

src_install () {
	dobin  src/swish-e
	
	dodoc INSTALL README 
}
