# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-x11/qt-x11-3.0.0.ebuild,v 1.4 2001/11/19 14:33:58 danarmak Exp $

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
    mv qmake.conf tmp
    echo "
QMAKE_CFLAGS = ${CFLAGS}
QMAKE_CXXFLAGS = ${CXXFLAGS}
" > tmp2
    cat tmp tmp2 > qmake.conf
    rm tmp tmp2

    use objprelink && patch -p0 < ${FILESDIR}/qt-x11-3-objprelink.patch
}

src_compile() {

	export LDFLAGS="-ldl"

	use opengl												|| myconf="-no-opengl"
	use nas			&& myconf="${myconf} -system-nas-sound"
	use gif			&& myconf="${myconf} -qt-gif"
	[ "$DEBUG" ]	&& myconf="${myconf} -debug" 			|| myconf="${myconf} -release -no-g++-exceptions"

	./configure -sm -thread -stl -system-zlib -system-libjpeg ${myconf} \
	-system-libmng -system-libpng -ldl -lpthread -no-xft || die # -prefix ${D}/${QTBASE}

	make || die

}

src_install() {

	cd ${S}
	mkdir -p ${D}${QTBASE}
	cp -r examples tutorial ${D}${QTBASE}

	for x in bin lib include include/private; do
	    mkdir -p ${D}${QTBASE}/${x}
	    cd ${S}/${x}
	    cp * ${D}${QTBASE}/${x}
	done

	cd ${S}
	dodoc ANNOUNCE INSTALL FAQ LICENSE* MANIFEST PLATFORMS PORTING README* changes-*
	dodir ${QTBASE}/share/doc/
	cp -af ${S}/doc/html ${D}${QTBASE}/share/doc/

	cd ${D}
	ln -s /${QTBASE} usr/lib/qt-x11-3
	insinto /etc/env.d
	newins ${FILESDIR}/30qt.3 30qt
	doins ${FILESDIR}/45qt-x11-3.0.0

}




