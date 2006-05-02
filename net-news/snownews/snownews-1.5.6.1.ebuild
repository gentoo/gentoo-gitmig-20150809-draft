# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/snownews/snownews-1.5.6.1.ebuild,v 1.3 2006/05/02 01:46:40 weeve Exp $

DESCRIPTION="Snownews, a text-mode RSS/RDF newsreader"
HOMEPAGE="http://snownews.kcore.de/"
SRC_URI="http://home.kcore.de/~kiza/software/snownews/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.5.6
	>=sys-libs/ncurses-5.3"

RDEPEND="dev-perl/XML-LibXML
	dev-perl/XML-LibXSLT
	dev-perl/libwww-perl"

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make PREFIX=${D}/usr install || die "make install failed"

	dodoc AUTHOR CREDITS README README.colors README.de README.patching
}
