# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/pglogd/pglogd-2.3.ebuild,v 1.2 2005/07/09 18:56:50 swegener Exp $

inherit eutils

DESCRIPTION="pgLOGd writes web server log entries to a PostgreSQL database"
HOMEPAGE="http://www.digitalstratum.com/pglogd/"
SRC_URI="http://www.digitalstratum.com/pglogd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-db/libpq"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile.patch
}

src_install() {
	dobin pglogctl
	dosbin pglogd
	dodoc CHANGELOG README pglogd_tables.sql weblog_daily.sql queries.txt

	insinto /etc
	doins pglogd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/pglogd.init pglogd
}

pkg_postinst() {
	echo
	einfo "Create a database on PostgreSQL server,"
	einfo "default name pglogd, but call it what you want,"
	einfo "and create the required tables within the database. An SQL script is"
	einfo "included with the source /usr/share/doc/${PF}/pglogd_tables.sql.gz"
	einfo "to accomplish this:"
	einfo
	einfo "  # su - postgres"
	einfo "  $ createdb pglogd"
	einfo "  $ zcat /usr/share/doc/${PF}/pglogd_tables.sql.gz | psql pglogd"
	einfo "  $ exit"
	einfo
	einfo "Then, you need to edit /etc/pglogd.conf against your enviroment."
	einfo "Finally, start up pglogd."
	einfo "   # /etc/init.d/pglogd start before apache server."
	echo
}
