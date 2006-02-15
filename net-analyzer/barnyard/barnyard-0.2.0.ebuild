# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/barnyard/barnyard-0.2.0.ebuild,v 1.7 2006/02/15 21:54:12 jokey Exp $

IUSE="mysql postgres"

DESCRIPTION="Fast output system for Snort"
SRC_URI="mirror://sourceforge/barnyard/barnyard-${PV/_/-}.tar.gz"
HOMEPAGE="http://www.snort.org/dl/barnyard/"

SLOT="0"
LICENSE="QPL"
KEYWORDS="x86 -sparc"

DEPEND="virtual/libc
	net-libs/libpcap
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )"

RDEPEND="${DEPEND}
	net-analyzer/snort"

S=${WORKDIR}/${P/_/-}

src_compile() {
	local myconf

	econf \
		--sysconfdir=/etc/snort \
		`use_enable postgres` \
		`use_enable mysql`|| die "bad ./configure"
	emake || die "compile problem"
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc docs/*
	dodoc AUTHORS  COPYING  LICENSE.QPL  README

	dodir /var/log/snort
	keepdir /var/log/snort
	dodir /var/log/snort/archive
	keepdir /var/log/snort/archive

	insinto /etc/snort  ; newins etc/barnyard.conf barnyard.conf.dist
	insinto /etc/conf.d ; newins ${FILESDIR}/barnyard.confd barnyard
	exeinto /etc/init.d ; newexe ${FILESDIR}/barnyard.rc6 barnyard
}
