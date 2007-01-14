# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pgsql/mod_auth_pgsql-0.9.12-r1.ebuild,v 1.5 2007/01/14 01:30:54 chtekk Exp $

inherit apache-module multilib

KEYWORDS="~amd64 ~x86"

DESCRIPTION="This module allows user authentication (and can log authentication requests) against information stored in a PostgreSQL database."
HOMEPAGE="http://www.giuseppetanzilli.it/mod_auth_pgsql/"
SRC_URI="http://www.giuseppetanzilli.it/mod_auth_pgsql/dist/${P}.tar.gz"
LICENSE="freedist"
SLOT="1"
IUSE=""

DEPEND="dev-db/libpq"
RDEPEND="${DEPEND}"

APACHE1_MOD_CONF="80_mod_auth_pgsql_ap1"
APACHE1_MOD_DEFINE="AUTH_PGSQL"

DOCFILES="INSTALL README mod_auth_pgsql.html"

need_apache1

src_compile() {
	econf \
		--with-apxs=${APXS1} \
		--with-pgsql-include=/usr/include/postgresql \
		--with-pgsql-lib=/usr/$(get_libdir)/postgresql \
		|| die "econf failed"
	${APXS1} \
		-I/usr/include/postgresql \
		-L/usr/$(get_libdir)/postgresql -lpq \
		-o mod_auth_pgsql.so -c mod_auth_pgsql.c auth_pgsql_shared_stub.c \
		|| die "apxs make failed"
}

src_install() {
	apache-module_src_install
	fperms 600 "${APACHE1_MODULES_CONFDIR}"/$(basename ${APACHE1_MOD_CONF}).conf
}
