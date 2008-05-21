# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sphinx/sphinx-0.9.7.ebuild,v 1.3 2008/05/21 15:51:36 dev-zero Exp $

inherit eutils autotools

DESCRIPTION="Full-text search engine with support for MySQL and PostgreSQL"
HOMEPAGE="http://www.sphinxsearch.com/"
SRC_URI="http://sphinxsearch.com/downloads/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mysql postgres debug"

DEPEND="mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-sandbox.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_with mysql) \
		$(use_with postgres) \
		$(use_with debug) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc doc/* example.sql
	dodir /etc/sphinx
	insinto /etc/sphinx
	doins sphinx.conf.dist

	dodir /var/lib/sphinx
	dodir /var/log/sphinx
	dodir /var/run/sphinx
}
