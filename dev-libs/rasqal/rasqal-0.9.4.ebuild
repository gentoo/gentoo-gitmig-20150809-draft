# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rasqal/rasqal-0.9.4.ebuild,v 1.2 2004/11/11 19:58:54 vapier Exp $

DESCRIPTION="library that handles Resource Description Framework (RDF)"
HOMEPAGE="http://librdf.org/rasqal/"
SRC_URI="http://librdf.org/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="media-libs/raptor"
#RDEPEND=""

src_compile() {
	econf --with-raptor=system || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README
}
