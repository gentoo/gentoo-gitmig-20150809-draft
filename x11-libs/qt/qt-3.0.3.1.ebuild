# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.0.3.1.ebuild,v 1.8 2002/08/08 08:13:16 danarmak Exp $

# qt-copy-3.0.3 ebuild (released with kde3)

PV=3.0.3
S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="QT version ${PV}"
SLOT="3"
LICENSE="QPL-1.0"
KEYWORDS="x86 ppc"


inherit kde.org
SRC_URI=${SRC_URI//qt-3.0.3.1/qt-copy-3.0.3}
S=${WORKDIR}/qt-copy-3.0.3
#SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-free-${PV}.tar.gz"

HOMEPAGE="http://www.trolltech.com/"

DEPEND="virtual/x11
	media-libs/libpng
	>=media-libs/libmng-1.0.0
	>=media-libs/freetype-2
	gif? ( media-libs/giflib
		media-libs/libungif )
	nas? ( >=media-libs/nas-1.4.1 )
	odbc? ( >=dev-db/unixODBC-2.0 )
	mysql? ( >=dev-db/mysql-3.2.10 )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( =dev-db/postgresql-7.1.3* )"
	

QTBASE=/usr/qt/3
export QTDIR=${S}

src_unpack() {

	export QTDIR=${S}

	unpack ${A}

	cd ${S}
	cp configure configure.orig
	sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure

}

src_compile() {

	export QTDIR=${S}
	
	export LDFLAGS="-ldl"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql -I/usr/include/postgresql/libpq -L/usr/lib"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc"
	[ -n "$DEBUG" ]	&& myconf="${myconf} -debug" 		|| myconf="${myconf} -release -no-g++-exceptions"
	
	# avoid wasting time building things we won't install
	rm -rf tutorial examples
	
	./configure -sm -thread -stl -system-zlib -system-libjpeg -qt-imgfmt-{jpeg,mng,png} ${myconf} \
		-system-libmng -system-libpng -ldl -lpthread -xft || die

	export QTDIR=${S}

	emake src-qmake src-moc sub-src sub-tools || die

}

src_install() {


	export QTDIR=${S}

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

	# version symlinks - 3.0.3->3.0->3->.so
	ln -s libqt-mt.so.${PV} libqt-mt.so.3.0
	ln -s libqt-mt.so.3.0 libqt-mt.so.3
	ln -s libqt-mt.so.3 libqt-mt.so

	# libqt -> libqt-mt symlinks
	ln -s libqt-mt.so.${PV} 	libqt.so.${PV}
	ln -s libqt-mt.so.3.0	libqt.so.3.0
	ln -s libqt-mt.so.3		libqt.so.3
	ln -s libqt-mt.so		libqt.so

	# includes
	cd ${S}
	dodir ${QTBASE}/include/private
	cp include/* ${D}/${QTBASE}/include/
	cp include/private/* ${D}/${QTBASE}/include/private/

	# misc
	insinto /etc/env.d
	doins ${FILESDIR}/{45qt3,50qtdir3}

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

}
