# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpreludedb/libpreludedb-1.0.0-r1.ebuild,v 1.1 2010/05/27 16:27:51 jer Exp $

EAPI="2"

inherit eutils flag-o-matic perl-module

DESCRIPTION="Prelude-IDS framework for easy access to the Prelude database"
HOMEPAGE="http://www.prelude-technologies.com"
SRC_URI="${HOMEPAGE}/download/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc mysql postgres perl python sqlite swig"

RDEPEND=">=dev-libs/libprelude-0.9.9
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	sqlite? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_configure() {
	local myconf

	econf \
		$(use_enable doc gtk-doc) \
		$(use_with mysql) \
		$(use_with postgres postgresql) \
		$(use_with sqlite sqlite3) \
		$(use_with perl) \
		$(use_with swig) \
		$(use_with python) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" INSTALLDIRS=vendor install || die "make install failed"

	if use perl; then
		perl_delete_localpod
		perl_delete_packlist
	fi
}

pkg_postinst() {
	elog "For additional installation instructions go to"
	elog "https://trac.prelude-ids.org/wiki/InstallingLibpreludedb"
}
