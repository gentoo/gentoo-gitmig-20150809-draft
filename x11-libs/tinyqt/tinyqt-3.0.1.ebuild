# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/tinyqt/tinyqt-3.0.1.ebuild,v 1.1 2002/02/21 23:41:08 gbevin Exp $

P=qt-x11-${PV}
S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="Stripped down version of qt ${PV} for commandline development"
SLOT="3"
SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND="virtual/glibc"

QTBASE=/usr/qt/tiny
export QTDIR=${S}

src_unpack() {

    unpack ${A}

    cd ${S}
	patch -p0 < ${FILESDIR}/configure.patch
	cp -a ${FILESDIR}/tinyqt ${S}/src
}

src_compile() {

	export LDFLAGS="-ldl"

	./configure -release -no-g++-exceptions || die
	cp ${S}/src/tinyqt/qconfig.h ${S}/include
	cd ${S}/src/tinyqt
	../../bin/qmake tinyqt.pro
	emake
}

src_install() {

    cd ${S}

    # binaries
    into $QTBASE
    dobin bin/*

    # libraries
	strip lib/liblibtinyqt.a
    dolib lib/liblibtinyqt.a

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
}
