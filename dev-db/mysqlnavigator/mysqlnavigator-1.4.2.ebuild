# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqlnavigator/mysqlnavigator-1.4.2.ebuild,v 1.17 2007/01/04 14:35:01 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils qt3 autotools

IUSE=""
DESCRIPTION="Advanced Qt based front end to mysql"
SRC_URI="http://sql.kldp.org/snapshots/source/${P}.tar.gz
		mirror://gentoo/${P}-gcc34.patch.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mysqlnavigator"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc x86"

DEPEND="virtual/mysql
		$(qt_min_version 3.1)"
		#!>=virtual/mysql-4.0

src_unpack() {
	unpack ${A}
	#gcc 3.4 fix thanks to tcort@cs.ubishops.ca
	epatch ${P}-gcc34.patch || die
	#this permit to build against mysql >= 4.1.3
	epatch ${FILESDIR}/${P}-mysql-gt-4.1.3.patch || die

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
	eautoreconf
}

src_compile() {
	myconf="--with-mysql-includes=/usr/include/mysql"
	econf ${myconf} || die "econf failed"
	emake -DUSE_OLD_FUNCTIONS=1
}

src_install() {
	einstall
}
