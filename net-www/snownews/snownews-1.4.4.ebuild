# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/snownews/snownews-1.4.4.ebuild,v 1.1 2004/03/10 20:56:49 mholzer Exp $

DESCRIPTION="Snownews, a text-mode RSS/RDF newsreader"
HOMEPAGE="http://home.kcore.de/~kiza/software/snownews/"
SRC_URI="http://home.kcore.de/~kiza/software/snownews/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.5.6
	>=sys-libs/ncurses-5.3
	dev-perl/XML-LibXML"

S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
	make LOCALEPATH=/usr/share/locale || die
}

src_install() {
	make PREFIX=${D}/usr install || die
}
