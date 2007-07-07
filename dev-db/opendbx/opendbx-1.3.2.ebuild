# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/opendbx/opendbx-1.3.2.ebuild,v 1.1 2007/07/07 11:53:25 swegener Exp $

DESCRIPTION="OpenDBX - A database abstraction layer"
HOMEPAGE="http://www.linuxnetworks.de/opendbx/"
SRC_URI="http://www.linuxnetworks.de/opendbx/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres sqlite sqlite3"

DEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
	sqlite? ( <dev-db/sqlite-3 )
	sqlite3? ( =dev-db/sqlite-3* )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! ( use mysql || use postgres || use sqlite || use sqlite3 )
	then
		die "Need at least one of mysql, postgres, sqlite and sqlite3 activated!"
	fi
}

src_compile() {
	local backends=""

	use mysql && backends="${backends} mysql"
	use postgres && backends="${backends} pgsql"
	use sqlite && backends="${backends} sqlite"
	use sqlite3 && backends="${backends} sqlite3"

	CPPFLAGS="${CPPFLAGS} -I/usr/include/mysql" \
	econf --with-backends="${backends}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
