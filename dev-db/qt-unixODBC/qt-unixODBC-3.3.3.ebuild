# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/qt-unixODBC/qt-unixODBC-3.3.3.ebuild,v 1.1 2004/10/23 21:19:15 danarmak Exp $

inherit eutils

SRCTYPE="free"
DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"
SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-${SRCTYPE}-${PV}.tar.bz2"
IUSE=""
LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="3"
KEYWORDS="~x86"

DEPEND="~x11-libs/qt-$PV
	dev-db/unixODBC"

S=${WORKDIR}/qt-x11-${SRCTYPE}-${PV}

QTBASE=/usr/qt/3
export QTDIR=${S}
export PLATFORM=linux-g++

src_unpack() {
	unpack ${A}

	cd ${S}
	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure
}

src_compile() {
	export QTDIR=${S}
	export SYSCONF=${D}${QTBASE}/etc/settings

	# Let's just allow writing to these directories during Qt emerge
	# as it makes Qt much happier.
	addwrite "${QTBASE}/etc/settings"
	addwrite "$HOME/.qt"

	export YACC='byacc -d'

	./configure -sm -thread -stl -system-libjpeg -verbose -largefile \
		-qt-imgfmt-{jpeg,mng,png} -tablet -system-libmng \
		-system-libpng -lpthread -xft -platform ${PLATFORM} -xplatform \
		${PLATFORM} -xrender -prefix ${QTBASE} -fast ${myconf} \
		-dlopen-opengl -plugin-sql-odbc -L${QTBASE}/lib || die

	export QTDIR=${S}

	cd $S/plugins/src/sqldrivers/odbc
	emake || die
}

src_install() {
	mkdir -p $D/$QTBASE/plugins/sqldrivers
	cp $S/plugins/sqldrivers/libqsqlodbc.so $D/$QTBASE/plugins/sqldrivers/ || die
}
