# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpreludedb/libpreludedb-0.9.13.ebuild,v 1.6 2008/05/21 15:59:25 dev-zero Exp $

inherit flag-o-matic eutils

DESCRIPTION="Prelude-IDS framework for easy access to the Prelude database"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc mysql postgres perl python sqlite3 swig"

DEPEND="virtual/libc
	>=dev-libs/libprelude-0.9.10
	doc? ( dev-util/gtk-doc )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	sqlite3? ( =dev-db/sqlite-3* )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf

	econf \
		$(use_with doc gtk-doc) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		$(use_with sqlite3) \
		$(use_with perl) \
		$(use_with swig) \
		$(use_with python) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

pkg_postinst() {
	elog "For additional installation instructions go to"
	elog "https://trac.prelude-ids.org/wiki/InstallingLibpreludedb"
}
