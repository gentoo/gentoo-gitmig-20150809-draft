# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdns/pdns-2.9.8.ebuild,v 1.8 2004/07/14 23:37:33 agriffis Exp $

DESCRIPTION="The PowerDNS Daemon."
SRC_URI="http://downloads.powerdns.com/releases/${P}.tar.gz"
HOMEPAGE="http://www.powerdns.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mysql static"

DEPEND="virtual/libc
	mysql? ( >=dev-db/mysql-3.23.54a )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf=""
	local modules=""

	use static && myconf="$myconf --enable-static-binaries"
	use mysql && modules="gmysql $modules"
	myconf="$myconf --with-modules=$modules"

	econf $myconf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ChangeLog HACKING INSTALL README TODO WARNING pdns/COPYING

	exeinto /etc/init.d
	doexe ${FILESDIR}/pdns

	mv ${D}/etc/pdns.conf-dist ${D}/etc/pdns.conf
}
