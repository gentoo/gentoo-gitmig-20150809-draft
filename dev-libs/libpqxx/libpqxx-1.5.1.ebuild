# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-1.5.1.ebuild,v 1.8 2005/02/09 22:07:00 nakano Exp $

IUSE=""
DESCRIPTION="a modern C++ frontend to the PostgresSQL database."
HOMEPAGE="http://pqxx.tk"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqxx/stable/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="x86 amd64"
DEPEND=">=dev-db/postgresql-7.3.2"

src_compile() {
	econf || die "econf failed"
	emake
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS READ TODO
	dohtml doc/html/Reference/*.html
}
