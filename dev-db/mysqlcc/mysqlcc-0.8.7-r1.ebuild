# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqlcc/mysqlcc-0.8.7-r1.ebuild,v 1.2 2003/06/12 20:29:57 msterret Exp $

S=${WORKDIR}/${P}-src
DESCRIPTION="a MySQL GUI Client"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="ftp://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MyCC/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X qt"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.0.5
	dev-db/mysql"
RDEPEND=""

inherit eutils

src_unpack() {
	unpack ${P}-src.tar.gz ; cd ${S}
	epatch ${FILESDIR}/${P}-qmakespec.patch
	epatch ${FILESDIR}/${P}-configperms.patch
}

src_compile() {
	# The config.sub in this distribution appears to be very stale
	# so we replace it with one from a known better source.  I am
	# not attached to using 1.4, but it seemed like it had the best
	# chance of compatibility.
	# Robert Coie <rac@gentoo.org> 2003.03.03
	if [ -e /usr/share/automake-1.4/config.sub ]; then
		cp /usr/share/automake-1.4/config.sub ${S}
	fi
	cd ${S}; autoreconf -f; 

	econf || die

	cp Makefile Makefile.orig
	sed -e "s:CFLAGS   = -pipe -Wall -W -g:CFLAGS   = ${CFLAGS}:" \
		-e "s:CXXFLAGS = -pipe -Wall -W -g:CXXFLAGS = ${CXXFLAGS}:" \
		Makefile.orig > Makefile
		
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
