# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-1.0.7.ebuild,v 1.3 2008/05/19 19:40:36 dev-zero Exp $

DESCRIPTION="High-level interface for the Resource Description Framework"
HOMEPAGE="http://librdf.org"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="berkdb mysql postgres sqlite ssl threads xml"

RDEPEND="mysql? ( virtual/mysql )
	sqlite? ( =dev-db/sqlite-3* )
	berkdb? ( sys-libs/db )
	xml? ( dev-libs/libxml2 )
	!xml? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	>=media-libs/raptor-1.4.16
	>=dev-libs/rasqal-0.9.15
	postgres? ( virtual/postgresql-base )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf

	if use xml; then
		myconf="${myconf} --with-xml-parser=libxml"
	else
		myconf="${myconf} --with-xml-parser=expat"
	fi

	econf --with-raptor=system \
		--with-rasqal=system \
		$(use_with berkdb bdb) \
		$(use_with ssl openssl-digests) \
		$(use_with mysql) \
		$(use_with threads) \
		$(use_with sqlite) \
		$(use_with postgres postgresql) \
		${myconf}

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog* NEWS NOTICE README TODO
	dohtml {FAQS,NEWS,README,RELEASE,TODO}.html
}
