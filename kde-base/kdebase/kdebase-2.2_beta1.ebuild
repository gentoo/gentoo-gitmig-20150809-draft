# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-2.2_beta1.ebuild,v 1.2 2001/08/06 20:57:20 achim Exp $

V="2.2beta1"
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${V} - Base"
SRC_PATH="kde/unstable/${V}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}
        >=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	lame? ( >=media-sound/lame-3.88b-r1 )
	vorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )"

src_compile() {
    local myconf
    if [ "`use ldap`" ]
    then
      myconf="--with-ldap"
    fi
    if [ "`use pam`" ]
    then
      myconf="$myconf --with-pam"
    else
      myconf="$myconf --with-shadow"
    fi
    if [ "`use qtmt`" ]
    then
      myconf="$myconf --enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    if [ -z "`use motif`" ]
    then
      myconf="$myconf --without-motif"
    fi
    if [ "`use lame`" ]
    then
      myconf="$myconf --with-lame=/usr"
    else
      myconf="$myconf --without-lame"
    fi
    if [ -z "`use cups`" ]
    then
      myconf="$myconf --without-cups"
    fi
    if [ -z "`use vorbis`" ]
    then
      myconf="$myconf --without-vorbis"
    fi
    QTBASE=/usr/X11R6/lib/qt
    export CFLAGS="${CFLAGS} -I/usr/X11R6/include"
    export CXXFLAGS="${CXXFLAGS} -I/usr/X11R6/include"
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} --with-x \
		 ${myconf} --with-xinerama \
		--with-qt-dir=$QTBASE 
    try make
}


src_install() {
  try make install DESTDIR=${D}
  insinto /etc/pam.d
  newins ${FILESDIR}/kscreensaver.pam kscreensaver
  cd ${D}/etc/X11/xdm
  mv Xsession Xsession.kde
  insinto /opt/kde${V}/share/config
  doins ${FILESDIR}/kdmrc
  sed -e "s:^kdmdesktop:/opt/kde${V}/kdmdesktop:" Xsetup_0 > Xsetup
  cd ${S}
  dodoc AUTHORS ChangeLog README*
  sed -e "s:^#\!/bin/sh:#\!/bin/sh --login:" ${D}/opt/kde${V}/bin/startkde > ${D}/opt/kde${V}/bin/startkde.tmp
  mv ${D}/opt/kde${V}/bin/startkde.tmp ${D}/opt/kde${V}/bin/startkde
  chmod a+x ${D}/opt/kde${V}/bin/startkde
}


