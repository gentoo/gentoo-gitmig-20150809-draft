# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.0.5-r2.ebuild,v 1.13 2004/01/07 00:04:56 agriffis Exp $

DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"
SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-free-${PV}.tar.gz"

LICENSE="QPL-1.0 | GPL-2"
SLOT="3"
KEYWORDS="x86 ppc sparc ia64 alpha"
IUSE="nas nls postgres opengl mysql odbc gif"

DEPEND="virtual/x11
	media-libs/libpng
	media-libs/lcms
	media-libs/jpeg
	>=media-libs/libmng-1.0.0
	>=media-libs/freetype-2
	nas? ( >=media-libs/nas-1.4.1 )
	odbc? ( >=dev-db/unixODBC-2.0 )
	mysql? ( >=dev-db/mysql-3.2.10 )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( >=dev-db/postgresql-7.2 )"

S=${WORKDIR}/qt-x11-free-${PV}

QTBASE=/usr/qt/3
export QTDIR=${S}

src_unpack() {
	unpack qt-x11-free-${PV}.tar.gz

	# qt patch - for ami, fixed on the spot bug.
	cd ${S}
	use nls && epatch ${FILESDIR}/qt-x11-free-3.0.5-ko_input.patch

	cd ${S}
	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure

	cd $S/mkspecs/linux-g++
	# use env's $CC, $CXX
	if [ -n "$CXX" ]; then
		einfo 'Using environment definition of $CXX'
		cp qmake.conf qmake.conf.orig
		sed -e "s:= g++:= ${CXX}:" qmake.conf.orig > qmake.conf
	fi
	if [ -n "$CC" ]; then
		einfo 'Using environment definition of $CC'
		cp qmake.conf qmake.conf.orig
		sed -e "s:= cc:= ${CC}:" qmake.conf.orig > qmake.conf
	fi
}

src_compile() {
	export LDFLAGS="-ldl"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc"
	use opengl	&& myconf="${myconf} -enable-module=opengl" || myconf="${myconf} -disable-opengl"
	use debug	&& myconf="${myconf} -debug" || myconf="${myconf} -release -no-g++-exceptions"

	# avoid wasting time building things we won't install
	rm -rf tutorial examples

	export YACC='byacc -d'

	./configure -sm -thread -stl -system-zlib -system-libjpeg -tablet \
		-system-libmng -system-libpng -ldl -lpthread -xft -platform linux-g++ \
		-qt-imgfmt-{jpeg,mng,png} -xplatform linux-g++ -prefix ${QTBASE} \
		${myconf} || die

	export QTDIR=${S}
	emake src-qmake src-moc sub-src sub-tools || die
}

src_install() {
	# binaries
	into $QTBASE
	dobin bin/*

	# libraries
	dolib lib/libqt-mt.so.${PV} lib/libqui.so.1.0.0 lib/libeditor.so.1.0.0
	cd ${D}$QTBASE/lib
	for x in libqui.so libeditor.so ; do
		ln -s $x.1.0.0 $x.1.0
		ln -s $x.1.0 $x.1
		ln -s $x.1 $x
	done

	# version symlinks - 3.0.3->3.0->3->.so
	ln -s libqt-mt.so.${PV} libqt-mt.so.3.0
	ln -s libqt-mt.so.3.0 libqt-mt.so.3
	ln -s libqt-mt.so.3 libqt-mt.so

	# libqt -> libqt-mt symlinks
	ln -s libqt-mt.so.${PV} libqt.so.${PV}
	ln -s libqt-mt.so.3.0 libqt.so.3.0
	ln -s libqt-mt.so.3 libqt.so.3
	ln -s libqt-mt.so libqt.so

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

pkg_postinst() {
	ewarn "NOTE: If you are upgrading from an older QT,"
	ewarn "you must remerge any versions of kde-base/kdelibs"
	ewarn "and x11-themes/mosfet-liquid-widgets, or QT/KDE"
	ewarn "widget style plugns will not work!"
}
