# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.0.5.ebuild,v 1.3 2002/07/23 04:19:01 danarmak Exp $

S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="QT version ${PV}"
SLOT="3"
LICENSE="QPL-1.0"
KEYWORDS="x86"

SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-free-${PV}.tar.gz
	 ftp://ftp.nnongae.com/pub/gentoo/qt-copy-3.0.4-onthespot.patch"

HOMEPAGE="http://www.trolltech.com/"

DEPEND="virtual/x11
	media-libs/libpng
	media-libs/lcms
	>=media-libs/libmng-1.0.0
	gif? ( media-libs/giflib
		media-libs/libungif )
	nas? ( >=media-libs/nas-1.4.1 )
	odbc? ( >=dev-db/unixODBC-2.0 )
	mysql? ( >=dev-db/mysql-3.2.10 )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( >=dev-db/postgresql-7.2 )"
	

QTBASE=/usr/qt/3
export QTDIR=${S}

src_unpack() {

	export QTDIR=${S}

	unpack qt-x11-free-${PV}.tar.gz

	# qt patch - for ami, fixed on the spot bug. 
	# If you have any problem with this patch , you can remove it except Korean
	cd ${S}
	patch -p1 < ${DISTDIR}/qt-copy-3.0.4-onthespot.patch || die

	cd ${S}
	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure

}

src_compile() {

	export QTDIR=${S}
	
	export LDFLAGS="-ldl"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc"
	[ -n "$DEBUG" ]	&& myconf="${myconf} -debug" 		|| myconf="${myconf} -release -no-g++-exceptions"
	
	# avoid wasting time building things we won't install
	rm -rf tutorial examples

	export YACC='byacc -d'
	
	./configure -sm -thread -stl -system-zlib -system-libjpeg -qt-imgfmt-{jpeg,mng,png} ${myconf} \
		-tablet -system-libmng -system-libpng -ldl -lpthread -xft || die

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
