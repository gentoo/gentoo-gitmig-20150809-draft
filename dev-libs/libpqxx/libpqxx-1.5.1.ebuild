# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-1.5.1.ebuild,v 1.4 2004/03/14 12:22:40 mr_bones_ Exp $

DESCRIPTION="a modern C++ frontend to the PostgresSQL database."
HOMEPAGE="http://pqxx.tk"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqxx/stable/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="x86 amd64"
DEPEND=">=dev-db/postgresql-7.3.2"

src_compile() {
	econf
	emake
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS READ TODO
	dohtml doc/html/Reference/*.html
}
