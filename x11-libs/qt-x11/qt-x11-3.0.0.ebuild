# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/x11-libs/qt-x11/qt-x11-3.0.0.ebuild,v 1.4 2001/11/19 14:33:58 danarmak Exp

P=qt-x11-${PV}
S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="QT version ${PV}"

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND=">=media-libs/libpng-1.0.9
	>=media-libs/libmng-1.0.0
	opengl? ( virtual/opengl virtual/glu )
	nas? ( >=media-libs/nas-1.4.1 )
	objprelink? ( dev-util/objprelink )
	virtual/x11"

QTBASE=/usr/lib/qt-x11-${PV}
export QTDIR=${S}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp configure configure.orig
    sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure

    cd ${S}/mkspecs/linux-g++
#    mv qmake.conf tmp
#    echo "
#QMAKE_CFLAGS = ${CFLAGS}
#QMAKE_CXXFLAGS = ${CXXFLAGS}
#" > tmp2
#    cat tmp tmp2 > qmake.conf
#    rm tmp tmp2

    use objprelink && patch -p0 < ${FILESDIR}/qt-x11-3-objprelink.patch
	
	cd ${S}
	mv tools/assistant/helpdialogimpl.cpp tools/assistant/helpdialogimpl.cpp_orig
	sed -e 's:"/doc/html:"/share/doc/html:g' \
		tools/assistant/helpdialogimpl.cpp_orig > tools/assistant/helpdialogimpl.cpp
	mv tools/assistant/mainwindow.ui.h tools/assistant/mainwindow.ui.h_orig
	sed -e 's:"/doc/html:"/share/doc/html:g' \
		tools/assistant/mainwindow.ui.h_orig > tools/assistant/mainwindow.ui.h
	
}

src_compile() {

	export LDFLAGS="-ldl"

	use opengl												|| myconf="-no-opengl"
	use nas			&& myconf="${myconf} -system-nas-sound"
	use gif			&& myconf="${myconf} -qt-gif"
	[ "$DEBUG" ]	&& myconf="${myconf} -debug" 			|| myconf="${myconf} -release -no-g++-exceptions"

	./configure -sm -thread -stl -system-zlib -system-libjpeg ${myconf} \
		-system-libmng -system-libpng -ldl -lpthread -no-xft -prefix ${D}/${QTBASE} \
		-docdir ${D}${QTBASE}/share/doc || die

	emake || die

}

src_install() {

	cd ${S}
	mkdir -p ${D}${QTBASE}
	cp -r examples tutorial ${D}${QTBASE}

	for x in bin include include/private; do
	    mkdir -p ${D}${QTBASE}/${x}
	    cd ${S}/${x}
	    cp -f * ${D}${QTBASE}/${x}
	done
	
	for x in lib mkspecs/linux-g++; do
	    mkdir -p ${D}${QTBASE}/${x}
	    cd ${S}/${x}
	    cp -af * ${D}${QTBASE}/${x}
	done
	
	sed -e "s:${D}::g" \
		-e "s:qt-x11-free-3.0.0:qt-x11-3.0.0:g" \
		-e "s:${WORKDIR}:${QTBASE}:" \
		${S}/.qmake.cache > ${D}${QTBASE}/.qmake.cache

	cd ${S}
	plugins=`find plugins -name "lib*.so" -print`
	for x in $plugins; do
		mkdir -p ${D}${QTBASE}/`dirname $x`
		cp $x ${D}${QTBASE}/$x
	done
	
	cd ${S}
	dodoc ANNOUNCE INSTALL FAQ LICENSE* MANIFEST PLATFORMS PORTING README* changes-*
	dodir ${QTBASE}/share
	dodir ${QTBASE}/share/doc
	cp -af ${S}/doc/man ${D}${QTBASE}/share
	cp -af ${S}/doc/*.doc ${D}${QTBASE}/share/doc
	cp -af ${S}/doc/html ${D}${QTBASE}/share/doc
	

	cd ${D}
	ln -s /${QTBASE} usr/lib/qt-x11-3
	insinto /etc/env.d
	newins ${FILESDIR}/30qt.3 30qt
	doins ${FILESDIR}/45qt-x11-3.0.0

}
