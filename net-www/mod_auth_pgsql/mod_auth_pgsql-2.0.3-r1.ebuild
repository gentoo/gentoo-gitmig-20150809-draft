# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pgsql/mod_auth_pgsql-2.0.3-r1.ebuild,v 1.1 2006/08/26 21:53:54 nakano Exp $

inherit apache-module

DESCRIPTION="This module allows user authentication (and can log authentication requests) against information stored in a PostgreSQL database."
HOMEPAGE="http://www.giuseppetanzilli.it/mod_auth_pgsql2/"
SRC_URI="http://www.giuseppetanzilli.it/mod_auth_pgsql2/dist/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="freedist"
SLOT="2"
DEPEND="dev-db/libpq"
IUSE=""

APXS2_ARGS="-a -c -I /usr/pgsql/include -L /usr/pgsql/lib -lpq mod_auth_pgsql.c"

APACHE2_MOD_CONF="2.0.2-r2/80_mod_auth_pgsql"
APACHE2_MOD_DEFINE="AUTH_PGSQL"

DOCFILES="INSTALL README TODO mod_auth_pgsql.html"

need_apache2

src_install() {
	apache-module_src_install
	fperms 600 ${APACHE2_MODULES_CONFDIR}/$(basename ${APACHE2_MOD_CONF}).conf
}
