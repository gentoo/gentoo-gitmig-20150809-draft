# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqlcc/mysqlcc-0.8.6a.ebuild,v 1.4 2003/03/01 04:35:55 vapier Exp $

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="a MySQL GUI Client"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="ftp://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MyCC/${PN}-0.8.6a-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X qt"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.0.5
	dev-db/mysql"
RDEPEND=""

src_unpack() {
	unpack ${PN}-0.8.6a-src.tar.gz ; cd ${S}	
}

src_compile() {
	econf || die
	QTDIR=$QTDIR 
	emake || die
}

src_install() {
	dobin mysqlcc
	dodir /usr/share/mysqlcc
	insinto /usr/share/mysqlcc
	doins warning.wav information.wav error.wav syntax.txt
	dodir /usr/share/mysqlcc/translations
	insinto /usr/share/mysqlcc/translations 
	doins translations/Espanol.qm  translations/Espanol.ts  translations/Russian.qm  translations/Russian.ts
}
