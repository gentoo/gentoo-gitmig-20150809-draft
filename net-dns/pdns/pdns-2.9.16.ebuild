# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdns/pdns-2.9.16.ebuild,v 1.4 2004/07/14 23:37:33 agriffis Exp $

DESCRIPTION="The PowerDNS Daemon."
SRC_URI="http://downloads.powerdns.com/releases/${P}.tar.gz"
HOMEPAGE="http://www.powerdns.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres static ldap"

DEPEND="virtual/libc
	mysql? ( >=dev-db/mysql-3.23.54a )
	postgres? ( >=dev-cpp/libpqpp-4.0-r1 )
	ldap? ( >=net-nds/openldap-2.0.27-r4 )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf=""
	local modules=""

	use static && myconf="$myconf --enable-static-binaries"
	use postgres && myconf="$myconf --with-pgsql-includes=/usr/include"

	use mysql && modules="gmysql $modules"
	use postgres && modules="gpgsql $modules"
	use ldap && modules="ldap $modules"

	econf --with-modules="$modules" \
		$myconf || die "Configuration failed"

	emake || die "Make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog HACKING INSTALL README TODO WARNING pdns/COPYING

	exeinto /etc/init.d
	doexe ${FILESDIR}/pdns

	mv ${D}/etc/pdns.conf-dist ${D}/etc/pdns.conf
}
