# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/barnyard/barnyard-0.1.0.ebuild,v 1.10 2006/02/15 21:54:12 jokey Exp $

IUSE="mysql"

DESCRIPTION="Fast output system for Snort"
SRC_URI="http://www.snort.org/dl/barnyard/barnyard-${PV}.tar.gz"
HOMEPAGE="http://www.snort.org"

SLOT="0"
LICENSE="QPL"
KEYWORDS="x86 -sparc"

DEPEND="virtual/libc
	net-libs/libpcap
	mysql? ( >=dev-db/mysql-3.23.26 )"

RDEPEND="${DEPEND}
	net-analyzer/snort"

src_compile() {
	local myconf
	myconf="${myconf} $(use_enable mysql)"

	if use mysql; then
		sed -i '/AC_CHECK_LIB(mysqlclient, mysql_connect, FOUND=yes, FOUND=no)/s/mysql_connect/mysql_real_connect/' \
		configure.in
	fi

	econf --sysconfdir=/etc/snort ${myconf} || die "econf failed"
	emake || die "compile problem"
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc docs/*
	dodoc AUTHORS  COPYING  LICENSE.QPL  README

	dodir /var/log/snort/archive
	keepdir /var/log/snort
	keepdir /var/log/snort/archive

	insinto /etc/snort  ; doins etc/barnyard.conf ; mv ${D}/etc/snort/barnyard.conf ${D}/etc/snort/barnyard.conf.dist
	insinto /etc/conf.d ; newins ${FILESDIR}/barnyard.confd barnyard
	insopts -m 755
	insinto /etc/init.d ; newins ${FILESDIR}/barnyard.rc6 barnyard
}
