# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.0.1-r3.ebuild,v 1.3 2002/02/10 16:48:33 verwilst Exp $

P=qt-x11-${PV}
S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="QT version ${PV}"
SLOT="2"
SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND=">=media-libs/libpng-1.0.9
	>=media-libs/libmng-1.0.0
	opengl? ( virtual/opengl virtual/glu )
	nas? ( >=media-libs/nas-1.4.1 )
	mysql? ( >=dev-db/mysql-3.2.10 )
	postgres? ( =dev-db/postgresql-7.1.3* )
	odbc? ( >=dev-db/unixODBC-2.0 )
	virtual/x11"

QTBASE=/usr/qt/3
export QTDIR=${S}

src_unpack() {

    unpack ${A}

    cd ${S}
    cp configure configure.orig
    sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure

}

src_compile() {

	export LDFLAGS="-ldl"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql -I/usr/include/postgresql/libpq -L/usr/lib"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc"
	[ -n "$DEBUG" ]	&& myconf="${myconf} -debug" 		|| myconf="${myconf} -release -no-g++-exceptions"

	./configure -sm -thread -stl -system-zlib -system-libjpeg ${myconf} \
		-system-libmng -system-libpng -ldl -lpthread -xft || die

	emake src-qmake src-moc sub-src sub-tools || die

}

src_install() {

    cd ${S}

    # binaries
    into $QTBASE
    dobin bin/*

    # libraries
    dolib lib/libqt-mt.so.${PV} lib/libqui.so.1.0.0 lib/libeditor.so.1.0.0
    cd ${D}$QTBASE/lib
    for x in libqui.so libeditor.so
    do
	ln -s $x.1.0.0 $x.1.0
	ln -s $x.1.0 $x.1
	ln -s $x.1 $x
    done
    ln -s libqt-mt.so.3.0.1 libqt-mt.so.3.0
    ln -s libqt-mt.so.3.0 libqt-mt.so.3
    ln -s libqt-mt.so.3 libqt-mt.so

    # includes
    cd ${S}
    dodir ${QTBASE}/include/private
    cp include/* ${D}/${QTBASE}/include/
    cp include/private/* ${D}/${QTBASE}/include/private/

    # misc
    insinto /etc/env.d
    doins ${FILESDIR}/45qt3

    # misc build reqs
    dodir ${QTBASE}/mkspecs
    cp -R ${S}/mkspecs/linux-g++ ${D}/${QTBASE}/mkspecs/

    sed -e "s:${D}::g" \
    	-e "s:qt-x11-free-3.0.1::g" \
	-e "s:${WORKDIR}:${QTBASE}:" \
	-e "s:/usr/local/qt:${QTBASE}:" \
	${S}/.qmake.cache > ${D}${QTBASE}/.qmake.cache

    # plugins
    cd ${S}
    plugins=`find plugins -name "lib*.so" -print`
    for x in $plugins; do
    	insinto ${QTBASE}/`dirname $x`
	doins $x
    done

    # misc
    insinto /etc/env.d
    doins ${FILESDIR}/49qt3
}
