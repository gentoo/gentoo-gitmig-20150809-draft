# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-postgres/ruby-postgres-0.7.1.ebuild,v 1.2 2003/05/13 00:14:49 twp Exp $

DESCRIPTION="An extension library to access a PostgreSQL database from Ruby"
HOMEPAGE="http://www.postgresql.jp/interfaces/ruby/"
SRC_URI="http://www.postgresql.jp/interfaces/ruby/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha arm hppa mips ppc sparc x86"
DEPEND=">=dev-lang/ruby-1.3.4
	>=dev-db/postgresql-6.4"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall || die
}
