# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tinyqt/tinyqt-3.0.3.ebuild,v 1.3 2002/04/27 10:31:46 seemant Exp $

MY_P=qt-x11-${PV}
S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="Stripped down version of qt ${PV} for console development"
SLOT="3"
SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.3-r5
	>=dev-util/yacc-1.9.1-r1
	>=sys-devel/flex-2.5.4a-r4"

QTBASE=/usr/qt/tiny
export QTDIR=${S}

src_unpack() {

    unpack ${A}

    cd ${S}
	patch -p0 < ${FILESDIR}/configure.patch || die
	cp -a ${FILESDIR}/tinyqt ${S}/src
	
	mv src/kernel/qurl.cpp src/kernel/qurl.cpp_orig
	sed -e "s#extern bool qt_resolve_symlinks;#bool qt_resolve_symlinks = TRUE;#" \
		src/kernel/qurl.cpp_orig > src/kernel/qurl.cpp
	rm src/kernel/qurl.cpp_orig
}

src_compile() {

	export LDFLAGS="-ldl"

	./configure -release -no-g++-exceptions || die
	cp ${S}/src/tinyqt/qconfig.h ${S}/include
	
	cd ${S}/src/moc
	../../bin/qmake moc.pro
	emake || die
	
	cd ${S}/src/tinyqt
	../../bin/qmake tinyqt.pro
	emake || die
	cp tinyqt.pro tinyqt.pro_copy
	sed -e "s# staticlib##" tinyqt.pro_copy > tinyqt.pro
	../../bin/qmake tinyqt.pro
	emake || die
}

src_install() {

    cd ${S}

    # binaries
    into $QTBASE
    dobin bin/*

    # libraries
    dolib lib/libtinyqt.a
    dolib lib/libtinyqt.so.3.0.2
    cd ${D}$QTBASE/lib
    ln -s libtinyqt.so.3.0.2 libtinyqt.so.3.0
    ln -s libtinyqt.so.3.0 libtinyqt.so.3
    ln -s libtinyqt.so.3 libtinyqt.so

    # includes
    cd ${S}
    dodir ${QTBASE}/include/private
    cp include/*.h ${D}/${QTBASE}/include/
    cp include/private/*.h ${D}/${QTBASE}/include/private/

    # misc
    insinto /etc/env.d
    doins ${FILESDIR}/47tinyqt

    # misc build reqs
    dodir ${QTBASE}/mkspecs
    cp -R ${S}/mkspecs/linux-g++ ${D}/${QTBASE}/mkspecs/
	mv ${D}/${QTBASE}/mkspecs/linux-g++/qmake.conf ${D}/${QTBASE}/mkspecs/linux-g++/qmake.conf_orig
	sed -e "s#-lqt#-ltinyqt#" \
		-e "s#/usr/X11R6/include##" \
		-e "s#/usr/X11R6/lib##" \
		-e "s#-lXext -lX11 -lm##" \
		-e "s#-lICE -lSM##" \
		${D}/${QTBASE}/mkspecs/linux-g++/qmake.conf_orig > ${D}/${QTBASE}/mkspecs/linux-g++/qmake.conf
	rm ${D}/${QTBASE}/mkspecs/linux-g++/qmake.conf_orig
}
