# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pgsql/mod_auth_pgsql-0.9.12-r1.ebuild,v 1.3 2005/02/26 17:13:08 nakano Exp $

inherit apache-module

DESCRIPTION="This module allows user authentication (and can log authentication requests) against information stored in a PostgreSQL database."
HOMEPAGE="http://www.giuseppetanzilli.it/mod_auth_pgsql/"
SRC_URI="http://www.giuseppetanzilli.it/mod_auth_pgsql/dist/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="freedist"
SLOT="1"
DEPEND="dev-db/postgresql"
IUSE=""

APACHE1_MOD_CONF="${PVR}/80_mod_auth_pgsql"
APACHE1_MOD_DEFINE="AUTH_PGSQL"

DOCFILES="INSTALL README mod_auth_pgsql.html"

need_apache1

src_compile() {
	econf --with-apxs=${APXS1} --with-pgsql-lib=/usr/lib/postgresql \
	--with-pgsql-include=/usr/include/postgresql || die "econf failed"
	${APXS1} -I/usr/include/postgresql \
		-L/usr/lib/postgresql -lpq \
		-o mod_auth_pgsql.so -c mod_auth_pgsql.c auth_pgsql_shared_stub.c || die
}

src_install() {
	apache-module_src_install
	fperms 600 ${APACHE2_MODULES_CONFDIR}/$(basename ${APACHE2_MOD_CONF}).conf
}

