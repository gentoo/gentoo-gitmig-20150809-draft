# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/snownews/snownews-1.5.6.ebuild,v 1.1 2004/12/08 19:49:35 citizen428 Exp $

DESCRIPTION="Snownews, a text-mode RSS/RDF newsreader"
HOMEPAGE="http://snownews.kcore.de/"
SRC_URI="http://home.kcore.de/~kiza/software/snownews/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.5.6
	>=sys-libs/ncurses-5.3"

RDEPEND="dev-perl/XML-LibXML
	dev-perl/XML-LibXSLT
	dev-perl/libwww-perl"

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	make PREFIX=${D}/usr install || die

	dodoc AUTHOR CREDITS README README.colors README.de README.patching
}
