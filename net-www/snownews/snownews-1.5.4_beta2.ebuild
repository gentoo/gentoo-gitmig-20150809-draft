# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/snownews/snownews-1.5.4_beta2.ebuild,v 1.1 2004/09/22 20:24:32 citizen428 Exp $

MY_PV=${PV/_/-}
S=${WORKDIR}/${PN}-${MY_PV}


DESCRIPTION="Snownews, a text-mode RSS/RDF newsreader"
HOMEPAGE="http://home.kcore.de/~kiza/software/snownews/"
SRC_URI="http://home.kcore.de/~kiza/software/snownews/download/beta/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.5.6
	>=sys-libs/ncurses-5.3
	dev-perl/XML-LibXML"

src_compile() {
	emake || die
}

src_install() {
	make PREFIX=${D}/usr install || die
	dodoc AUTHOR CREDITS Changelog README README.colors README.de README.patching
}
