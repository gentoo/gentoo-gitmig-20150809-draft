# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdns/pdns-2.9.12-r1.ebuild,v 1.1 2003/12/14 18:48:46 jhhudso Exp $

DESCRIPTION="The PowerDNS Daemon."
SRC_URI="http://downloads.powerdns.com/releases/${P}.tar.gz"
HOMEPAGE="http://www.powerdns.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres static"

DEPEND="virtual/glibc
	mysql? ( >=dev-db/mysql-3.23.54a )
	postgres? ( >=dev-libs/libpq++-4.0-r1 )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_compile() {
	local myconf=""
	local modules=""

	use static && myconf="$myconf --enable-static-binaries"
	use mysql && modules="gmysql $modules"
	use postgres && modules="gpgsql $modules"
	use postgres && myconf="$myconf --with-pgsql-includes=/usr/include"
	myconf="$myconf --with-modules=$modules"

	econf $myconf
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ChangeLog HACKING INSTALL README TODO WARNING pdns/COPYING

	exeinto /etc/init.d
	doexe ${FILESDIR}/pdns

	mv ${D}/etc/pdns.conf-dist ${D}/etc/pdns.conf
}
