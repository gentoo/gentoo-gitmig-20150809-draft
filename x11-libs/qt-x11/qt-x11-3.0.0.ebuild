# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-x11/qt-x11-3.0.0.ebuild,v 1.2 2001/11/17 11:28:28 danarmak Exp $

# TODO: any beta6 -> final upgrades - none known of
# TODO: figure out sql support
# TODO: objprelink support - in testing
# TODO: get it to use CFLAGS, CXXFLAGS - done
# TODO: locate any qt-x11 vs. qt-x11-free problems - none known of

P=qt-x11-free-${PV}
S=${WORKDIR}/${P}

DESCRIPTION="${P}"

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/${P}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"

DEPEND=">=media-libs/libpng-1.0.9
	>=media-libs/libmng-1.0.0
	opengl? ( virtual/opengl virtual/glu )
	nas? ( >=media-libs/nas-1.4.1 )
	objprelink? ( dev-util/objprelink )
	virtual/x11"

QTBASE=/usr/lib/${P}
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

    use opengl		|| myconf="-no-opengl"
    use nas		&& myconf="${myconf} -system-nas-sound"	
    use gif		&& myconf="${myconf} -qt-gif"			
    [ "$DEBUG" ]	&& myconf="${myconf} -debug" 			|| myconf="${myconf} -release -no-g++-exceptions"
	
    ./configure -sm -thread -stl -system-zlib -system-libjpeg ${myconf} \
	-system-libmng -system-libpng -ldl -lpthread -prefix ${D}/${QTBASE} || die

    # Manually installing became increasingly complicated - see src_install() of
    # qt-x11-2.3.1.ebuild. So, we give it the prefix option and do make install
    # followed by dodoc etc. 
    # Note that there isn't a separate prefix here and destdir in make install,
    # so we have to give it a prefix with $D in it to begin with. 

    cd ${S}
    make || die

}

src_install() {


	cd ${S}
	
	make install
	
	cd ${S}
	cp -r examples tutorial ${D}${QTBASE}

	dodoc ANNOUNCE INSTALL FAQ LICENSE* MANIFEST PLATFORMS PORTING README* changes-*
	dodir ${QTBASE}/share/doc/
        cp -af ${S}/doc/html ${D}${QTBASE}/share/doc/
		
	cd ${D}
	ln -s /${QTBASE} usr/lib/qt-x11-3
	insinto /etc/env.d
	newins ${FILESDIR}/30qt.3 30qt
	doins ${FILESDIR}/49qt-x11-3.0.0

}




