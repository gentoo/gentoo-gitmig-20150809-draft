# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-x11/qt-x11-2.3.1-r3.ebuild,v 1.1 2001/11/03 10:36:51 danarmak Exp $
# note: this is the new revision that installs into /usr

S=${WORKDIR}/qt-${PV}
DESCRIPTION="QT ${PV}"
SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/${P}.tar.gz \
http://www.research.att.com/~leonb/objprelink/qt-configs.patch"
HOMEPAGE="http://www.trolltech.com/"

DEPEND=">=media-libs/libpng-1.0.9
	>=media-libs/libmng-1.0.0
	opengl? ( virtual/opengl virtual/glu )
	nas? ( >=media-sound/nas-1.4.1 )
	objprelink? ( dev-util/objprelink )
	virtual/x11"

export QTDIR=${S}

src_unpack() {
  unpack ${P}.tar.gz
  cd ${S}
  cp configure configure.orig
  sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure
  if [ "`use objprelink`" ]
  then
	patch -p0 < ${DISTDIR}/qt-configs.patch
  fi
  #patch -p0 <${FILESDIR}/${P}-gentoo-cxxflags.patch
  cd ${S}/configs
  cp linux-g++-shared 1
  sed -e "s/SYSCONF_CXXFLAGS	/SYSCONF_CXXFLAGS = ${CXXFLAGS} \#/" \
      -e "s/SYSCONF_CFLAGS	/SYSCONF_CFLAGS = ${CFLAGS} \#/" \
    1 > linux-g++-shared || die
  rm 1
}

src_compile() {

    export LDFLAGS="-ldl"
    local myconf

    if [ -z "`use opengl`" ]
    then
      myconf="-no-opengl"
    fi

    if [ "`use nas`" ]
    then
      myconf="${myconf} -system-nas-sound"
    else
      myconf="${myconf} -no-nas-sound"
    fi

    if [ "`use gif`" ]
    then
      myconf="${myconf} -gif"
    fi

    if [ "$DEBUG" ]
    then
      myconf="${myconf} -debug"
    else
      myconf="${myconf} -release"
    fi
	
    SYSCONF_CFLAGS="$CFLAGS" SYSCONF_CXXFLAGS="$CXXFLAGS" \
    ./configure -sm -thread -system-zlib -system-jpeg ${myconf} \
	-system-libmng -system-libpng -gif -platform linux-g++ \
        -ldl -lpthread -no-g++-exceptions || die

    cd ${S}
    SYSCONF_CFLAGS="$CFLAGS" SYSCONF_CXXFLAGS="$CXXFLAGS" make || die

}

src_install() {

        QTBASE=/usr/lib/${P}
	cd ${S}
	into $QTBASE
	dobin bin/*
	dolib.so lib/libqt.so.${PV}
	dolib.so lib/libqt-mt.so.${PV}
	dolib.so lib/libqutil.so.1.0.0
	preplib $QTBASE
	dosym	libqt.so.${PV} 	  $QTBASE/lib/libqt.so
	dosym   libqt-mt.so.${PV} $QTBASE/lib/libqt-mt.so
	dosym   libqutil.so.1.0.0 $QTBASE/lib/libqutil.so
	cd ${S}
	dodir ${QTBASE}/include
	cp include/* ${D}${QTBASE}/include/
	doman doc/man/man3/*

	dodoc ANNOUNCE FAQ LICENSE.QPL MANIFEST PLATFORMS
	dodoc PORTING README*
	dodir ${QTBASE}/share/doc/
        cp -af ${S}/doc/html ${D}${QTBASE}/share/doc/
		
	cd ${D}
	ln -s /${QTBASE} usr/lib/qt-x11-2
	insinto /etc/env.d
	newins ${FILESDIR}/30qt.2 30qt
	doins ${FILESDIR}/50${P}
	
	cd ${S}
	cp -r examples tutorial ${D}${QTBASE}

}




