# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqlcc/mysqlcc-0.9.4.ebuild,v 1.3 2004/03/30 08:38:19 aliz Exp $

inherit eutils

S=${WORKDIR}/${P}-src
DESCRIPTION="a MySQL GUI Client"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="ftp://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQLCC/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ssl"

DEPEND="virtual/glibc
	>=dev-db/mysql-4.0.0
	>=x11-libs/qt-3.0.5"

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-libmysqlclientac.patch
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

	if [ "`use ssl`" ]; then
		SUBLIBS="${SUBLIBS} -lssl"
		echo "libs now ${SUBLIBS}"
	fi

	QMAKESPEC="linux-g++" LIBS=${LIBS} econf --with-qt=${QTDIR} || die

	cp Makefile Makefile.orig
	sed -e "s:CFLAGS   = -pipe -Wall -W -O2:CFLAGS   = ${CFLAGS}:" \
		-e "s:CXXFLAGS = -pipe -Wall -W -O2:CXXFLAGS = ${CXXFLAGS}:" \
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
	doins translations/*.qm  translations/*.ts
	dodoc *.txt
}
