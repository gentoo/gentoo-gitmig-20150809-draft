# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pgsql/mod_auth_pgsql-2.0.2-r1.ebuild,v 1.4 2004/07/18 08:29:59 nakano Exp $

DESCRIPTION="This module allows user authentication (and can log authethication requests) against information stored in a PostgreSQL database."
SRC_URI="http://www.giuseppetanzilli.it/mod_auth_pgsql2/dist/${P}b1.tar.gz"
HOMEPAGE="http://www.giuseppetanzilli.it/mod_auth_pgsql2/"
KEYWORDS="x86 ~ppc ~sparc"
LICENSE="freedist"
SLOT="0"
DEPEND=">=net-www/apache-2.0.40
	dev-db/postgresql"
IUSE=""

S="${WORKDIR}/${P}b1"

src_compile() {
	apxs2 -a -c -I /usr/pgsql/include -L /usr/pgsql/lib -lpq mod_auth_pgsql.c || die "apxs2 failed."
}

src_install() {
	insinto /usr/lib/apache2-extramodules
	doins .libs/mod_auth_pgsql.so
	dodoc INSTALL README TODO
	dohtml mod_auth_pgsql.html

	insinto /etc/apache2/conf/modules.d/
	doins ${FILESDIR}/80_mod_auth_pgsql.conf
}

pkg_postinst() {
	einfo "Edit /etc/conf.d/apache2 and add \"-D AUTH_PGSQL\" to APACHE2_OPTS"
}
