# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/mydns/mydns-0.11.0.ebuild,v 1.6 2005/04/01 14:28:51 agriffis Exp $

DESCRIPTION="A DNS-Server which gets its data from mysql-databases"
HOMEPAGE="http://mydns.bboy.net/"
SRC_URI="http://mydns.bboy.net/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ia64"
IUSE="debug mysql nls postgres ssl static zlib"

RDEPEND="virtual/libc
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	|| (
		mysql? ( dev-db/mysql )
		postgres? ( dev-db/postgresql )
		!postgres? ( dev-db/mysql )
	)"
DEPEND="${RDEPEND}
	sys-devel/bison"

src_compile() {
	local myconf

	if use mysql || ! use postgres; then
		myconf="${myconf} --with-mysql"
	else
		myconf="${myconf} --without-mysql --with-pgsql"
	fi

	econf --enable-alias \
		`use_enable nls` \
		`use_enable debug` \
		`use_enable static static-build` \
		`use_with ssl openssl` \
		`use_with zlib` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog INSTALL NEWS README TODO

	exeinto /etc/init.d; newexe ${FILESDIR}/mydns.rc6-${PV} mydns || die

	if use mysql || ! use postgres; then
		sed -i -e 's/__db__/mysql/g' ${D}/etc/init.d/mydns || die
		dodoc QUICKSTART.mysql
	else
		sed -i -e 's/__db__/postgresql/g' ${D}/etc/init.d/mydns || die
		dodoc QUICKSTART.postgres
	fi
}

pkg_postinst() {
	einfo
	einfo "You should now run these commands:"
	einfo
	einfo "# /usr/sbin/mydns --dump-config > /etc/mydns.conf"
	einfo "# chmod 0600 /etc/mydns.conf"
	if use mysql || ! use postgres; then
		einfo "# mysqladmin -u <useruname> -p create mydns"
		einfo "# /usr/sbin/mydns --create-tables | mysql -u <username> -p mydns"
		einfo
		einfo "to create the tables in the MySQL-Database."
		einfo "For more info see QUICKSTART.mysql."
	else
		einfo "# createdb mydns"
		einfo "# /usr/sbin/mydns --create-tables | psql mydns"
		einfo
		einfo "to create the tables in the PostgreSQL-Database."
		einfo "For more info see QUICKSTART.postgres."
	fi
	einfo
}
