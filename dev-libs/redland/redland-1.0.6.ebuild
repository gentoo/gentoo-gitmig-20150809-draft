# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-1.0.6.ebuild,v 1.3 2007/09/01 09:40:39 phreak Exp $

inherit eutils

DESCRIPTION="High-level interface for the Resource Description Framework"
HOMEPAGE="http://librdf.org/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="berkdb mysql sqlite ssl threads"

DEPEND="mysql? ( virtual/mysql )
	sqlite? ( =dev-db/sqlite-3* )
	berkdb? ( sys-libs/db )
	dev-libs/libxml2
	ssl? ( dev-libs/openssl )
	>=media-libs/raptor-1.4.4
	>=dev-libs/rasqal-0.9.14"

src_unpack() {
	unpack ${A}
	rm -r "${S}"/{raptor,rasqal}
	epatch "${FILESDIR}"/${P}-fbsd.patch
}

src_compile() {
	econf \
		--with-raptor=system \
		--with-rasqal=system \
		$(use_with berkdb bdb) \
		$(use_with ssl openssl-digests) \
		$(use_with mysql) \
		$(use_with threads) \
		$(use_with sqlite) \
		|| die "econf failed!"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed!"
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
