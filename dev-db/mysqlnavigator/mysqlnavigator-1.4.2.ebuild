# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqlnavigator/mysqlnavigator-1.4.2.ebuild,v 1.1 2003/04/22 09:15:08 robbat2 Exp $

IUSE=""
DESCRIPTION="Advanced Qt based front end to mysql"
SRC_URI="http://sql.kldp.org/snapshots/source/${P}.tar.gz"
HOMEPAGE="http://sql.kldp.org/mysql"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-db/mysql-3.23.49
		>=x11-libs/qt-3.0.3"
		#!=dev-db/mysql-4*

src_unpack() {
	unpack ${A}
	#cleanup for QT
	cd ${S}/src/mysql
	rm */*_moc.cpp
	#cleanup to include CXXFLAGS
	cd ${S}
	mv configure.in configure.in.orig
	#add USE_OLD_FUNCTIONS to get it to compile with MySQL v4
	export CXXFLAGS="${CXXFLAGS} -DUSE_OLD_FUNCTIONS=1"
	sed "s|^CXXFLAGS=\".*\"$|CXXFLAGS=\"${CXXFLAGS}\"|g" <configure.in.orig >configure.in
	#force changes in
	autoreconf
}

src_compile() {
	myconf="--with-mysql-includes=/usr/include/mysql"
	econf ${myconf}
	emake -DUSE_OLD_FUNCTIONS=1
}

src_install() {
	einstall
}
