# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/io/io-2009.01.02-r2.ebuild,v 1.1 2012/03/19 10:05:26 pacho Exp $

DESCRIPTION="Io is a small, prototype-based programming language."
HOMEPAGE="http://www.iolanguage.com"
SRC_URI="mirror://gentoo/${P}.tar.gz
		http://dev.gentoo.org/~araujo/snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc readline mysql cairo postgres dbi opengl ncurses sqlite zlib lzo"
DEPEND="lzo? ( dev-libs/lzo )
		readline? ( sys-libs/readline )
		mysql? ( virtual/mysql )
		cairo? ( x11-libs/cairo )
		postgres? ( dev-db/postgresql-server )
		opengl? ( virtual/opengl )
		dbi? ( dev-db/libdbi )
		ncurses? ( sys-libs/ncurses )
		sqlite? ( >=dev-db/sqlite-3.0.0 )
		zlib? ( sys-libs/zlib )"
RDEPEND=""

src_compile() {
	make INSTALL_PREFIX="/usr" vm || die "make failed."
	# Building optional addons if any.
	use readline && make ReadLine
	use mysql && make MySQL
	use cairo && make Cairo
	use postgres && make PostgreSQL
	use opengl && make OpenGL
	use dbi && make DBI
	use ncurses && make Curses
	use sqlite && make SQLite3
	use zlib && make Zlib
	use lzo && make LZO
}

src_install() {
	make install \
		INSTALL_PREFIX="${D}/usr" \
		|| die "make install failed"
	if use doc; then
		dodoc docs/docs.css docs/*.html
	fi
}
