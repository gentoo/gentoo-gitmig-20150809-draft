# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/qt-docs/qt-docs-2.3.1.ebuild,v 1.3 2002/04/27 05:00:43 seemant Exp $

S=${WORKDIR}/qt-${PV}
DESCRIPTION="QT ${PV} docs, manpages, examples and tutorials"
SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

RDEPEND="=x11-libs/qt-2*"

DEPEND="$RDEPEND
	sys-devel/gcc"

export QTDIR=${S}

src_unpack() {

    unpack ${A}

    cd ${S}
    cp configure configure.orig
    sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure

    cd ${S}/configs
    cp linux-g++-shared linux-g++-shared.orig
    sed -e "s/SYSCONF_CXXFLAGS	/SYSCONF_CXXFLAGS = ${CXXFLAGS} \#/" \
	-e "s/SYSCONF_CFLAGS	/SYSCONF_CFLAGS = ${CFLAGS} \#/" \
	linux-g++-shared.orig > linux-g++-shared || die

}

src_compile() {

    export LDFLAGS="$LDFLAGS -ldl"
    local myconf

    use opengl							|| myconf="${myconf} -no-opengl"
    use nas	&& myconf="${myconf} -system-nas-sound"		|| myconf="${myconf} -no-nas-sound"
    use gif	&& myconf="${myconf} -gif"
    [ -n "$DEBUG" ]	&& myconf="${myconf} -debug"		|| myconf="${myconf} -release"

    ./configure -sm -thread -system-zlib -system-jpeg ${myconf} \
	-system-libmng -system-libpng -gif -platform linux-g++ \
        -ldl -lpthread -no-g++-exceptions || die

    # use already built x11-libs/qt
    export QTDIR=/usr/qt/2

	cd ${S}/tutorial
    make || die
    cd ${S}/examples
    make || die

}

src_install() {

    QTBASE=/usr/qt/2
    cd ${S}
    
    # docs
    cd ${S}
    dodoc ANNOUNCE README* INSTALL FAQ LICENSE* PLATFORMS PORTING

    # html docs
    dodir $QTBASE/doc
    cp -r ${S}/doc/html $D/$QTBASE/doc

    # manpages
    dodir $QTBASE/man
    cp -r ${S}/doc/man $D/$QTBASE

    # examples
    cp -r ${S}/examples $D/$QTBASE

    # tutorials
    cp -r ${S}/tutorial $D/$QTBASE
    
    # misc
    insinto /etc/env.d
    doins ${FILESDIR}/50qt-docs2

}




