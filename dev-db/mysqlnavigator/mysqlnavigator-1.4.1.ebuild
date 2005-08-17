# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqlnavigator/mysqlnavigator-1.4.1.ebuild,v 1.11 2005/08/17 18:42:36 vivo Exp $

inherit eutils qt3

IUSE=""
DESCRIPTION="Advanced Qt based front end to mysql"
SRC_URI="http://sql.kldp.org/snapshots/source/${P}.tar.gz"
HOMEPAGE="http://sql.kldp.org/mysql"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=dev-db/mysql-3.23.49
	$(qt_min_version 3.1)"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-about.patch || die
	epatch ${FILESDIR}/${P}-mysql.patch || die
	#this permit to build against mysql >= 4.1.3       
	epatch ${FILESDIR}/${PN}-1.4.2-mysql-gt-4.1.3.patch || die
	cd ${S}/src/mysql
	rm */*_moc.cpp
}

src_compile() {
	myconf="--with-mysql-includes=/usr/include/mysql"
	econf ${myconf} || die "econf failed"
	emake
}

src_install() {
	einstall
}
