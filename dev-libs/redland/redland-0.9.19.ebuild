# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-0.9.19.ebuild,v 1.2 2004/11/11 13:36:53 vapier Exp $

DESCRIPTION="High-level interface for the Resource Description Framework"
HOMEPAGE="http://librdf.org/"
SRC_URI="http://librdf.org/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="mysql ssl"

DEPEND="mysql? ( dev-db/mysql )
	dev-libs/libxml2
	ssl? ( dev-libs/openssl )
	media-libs/raptor
	dev-libs/rasqal"

src_unpack() {
	unpack ${A}
	rm -r "${S}"/{raptor,rasqal}
}

src_compile() {
	econf \
		--with-raptor=system \
		--with-rasqal=system \
		$(use_with ssl openssl-digests) \
		$(use_with mysql) \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
