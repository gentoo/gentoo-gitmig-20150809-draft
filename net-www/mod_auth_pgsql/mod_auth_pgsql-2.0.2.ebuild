# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pgsql/mod_auth_pgsql-2.0.2.ebuild,v 1.1 2004/04/02 18:42:59 zul Exp $

DESCRIPTION="This module allows user authentication (and can log authethication requests) against information stored in a PostgreSQL database."
SRC_URI="http://www.giuseppetanzilli.it/mod_auth_pgsql2/dist/${P}b1.tar.gz"
HOMEPAGE="http://www.giuseppetanzilli.it/mod_auth_pgsql2/"
KEYWORDS="~x86"
LICENSE="freedist"
SLOT="0"
DEPEND=">=net-www/apache-2.0.40
	dev-db/postgresql"

S="${WORKDIR}/${P}b1"

src_compile() {
	apxs2 -a -c -I /usr/pgsql/include -L /usr/pgsql/lib -lpq mod_auth_pgsql.c || die "apxs2 failed."
}

src_install() {
	insinto /usr/lib/apache2-extramodules
	doins .libs/mod_auth_pgsql.so
	dodoc INSTALL README TODO
	dohtml mod_auth_pgsql.html
}

