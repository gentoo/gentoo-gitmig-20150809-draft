# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/qt-docs/qt-docs-3.0.1.ebuild,v 1.2 2002/02/03 21:39:50 danarmak Exp $

P=qt-x11-${PV}
S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="QT version ${PV}"

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND="=x11-libs/qt-3*"

RDEPEND="$DEPEND sys-devel/gcc"

QTBASE=/usr/qt/3
export QTDIR=${S}

src_unpack() {

    unpack ${A}
    cd ${S}
    cp configure configure.orig
    sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure

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

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc"
	[ -n "$DEBUG" ]	&& myconf="${myconf} -debug" 		|| myconf="${myconf} -release -no-g++-exceptions"

	./configure -sm -thread -stl -system-zlib -system-libjpeg ${myconf} \
		-system-libmng -system-libpng -ldl -lpthread || die

	# use already built qt
	export QTDIR=/usr/qt/3

	# what's with the make doc target? it wants an executable qdoc in the path, and I haven't
	# been able to find it. FIXME!
	#cd ${S}
	#make doc || die
	cd ${S}/tutorial
	make || die
	cd ${S}/examples
	make || die

}

src_install() {

    cd ${S}
    
    # misc
    insinto /etc/env.d
    doins ${FILESDIR}/45qt-docs3

	# docs
	cd ${S}/doc
	dodir ${QTBASE}/doc
	for x in html flyers; do
		cp -r $x ${D}/${QTBASE}/doc
	done

	# manpages
	cp -r ${S}/doc/man ${D}/${QTBASE}

	# examples
	cp -r ${S}/examples ${D}/${QTBASE}

	# tutorials
	cp -r ${S}/tutorial ${D}/${QTBASE}

}


