# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-1.0.2.ebuild,v 1.2 2006/11/23 20:16:57 vivo Exp $

DESCRIPTION="High-level interface for the Resource Description Framework"
HOMEPAGE="http://librdf.org/"
SRC_URI="http://librdf.org/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="berkdb mysql sqlite ssl threads"

DEPEND="mysql? ( virtual/mysql )
	sqlite? ( =dev-db/sqlite-3* )
	berkdb? ( sys-libs/db )
	dev-libs/libxml2
	ssl? ( dev-libs/openssl )
	>=media-libs/raptor-1.4.4
	>=dev-libs/rasqal-0.9.6"

src_unpack() {
	unpack ${A}
	rm -r "${S}"/{raptor,rasqal}
}

src_compile() {
	local myconf=""
	use berkdb || myconf="${myconf} --without-bdb"
	use sqlite \
		&& myconf="${myconf} --with-sqlite-version=3" \
		|| myconf="${myconf} --with-sqlite-version=none"
	econf \
		--with-raptor=system \
		--with-rasqal=system \
		$(use_with ssl openssl-digests) \
		$(use_with mysql) \
		$(use_with threads) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
