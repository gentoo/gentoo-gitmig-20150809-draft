# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-2.2.ebuild,v 1.6 2001/08/22 11:29:04 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Base"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH
	 http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}
        >=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	lame? ( =media-sound/lame-3.88b-r1 )
	vorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( dev-libs/openssl )
	objprelink? ( dev-util/objprelink )"

src_unpack() {
	
	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	cd ${S}
	use objprelink && patch -p0 < ${DISTDIR}/kde-admin-acinclude.patch
	
}

src_compile() {
    local myconf
    if [ "`use ldap`" ] ; then
      myconf="--with-ldap"
    else
      myconf="--without-ldap"
    fi

    if [ "`use pam`" ] ; then
      myconf="$myconf --with-pam"
    else
      myconf="$myconf --with-shadow"
    fi

    if [ "`use qtmt`" ] ; then
      myconf="$myconf --enable-mt"
    fi

    if [ "`use mitshm`" ] ; then
      myconf="$myconf --enable-mitshm"
    fi

    if [ -z "`use motif`" ] ; then
      myconf="$myconf --without-motif"
    fi

    if [ "`use lame`" ] ; then
      myconf="$myconf --with-lame=/usr"
    else
      myconf="$myconf --without-lame"
    fi

    if [ -z "`use cups`" ] ; then
      myconf="$myconf --disable-cups"
    fi

    if [ -z "`use vorbis`" ] ; then
      myconf="$myconf --without-vorbis"
    fi

    if [ -z "`use opengl`" ] ; then
      myconf="$myconf --without-gl"
    fi

    if [ -z "`use ssl`" ] ; then
      myconf="$myconf --without-ssl"
    fi

	if [ "`use objprelink`" ] ; then
	  myconf="$myconf --enable-objprelink"
	fi

    QTBASE=/usr/X11R6/lib/qt
#    export CFLAGS="${CFLAGS} -I/usr/X11R6/include"
#    export CXXFLAGS="${CXXFLAGS} -I/usr/X11R6/include"
    ./configure --prefix=/opt/kde${PV} --host=${CHOST} --with-x \
		 ${myconf} --with-xinerama \
		--with-qt-dir=$QTBASE 
    try make
}


src_install() {
  try make install DESTDIR=${D}
  insinto /etc/pam.d
  newins ${FILESDIR}/kscreensaver.pam kscreensaver
  newins kde.pamd kde
  cd ${D}/etc/X11/xdm
  mv Xsession Xsession.kde
  insinto /opt/kde${PV}/share/config
  doins ${FILESDIR}/kdmrc
  sed -e "s:^kdmdesktop:/opt/kde${PV}/kdmdesktop:" Xsetup_0 > Xsetup
  cd ${S}
  dodoc AUTHORS ChangeLog README*
  sed -e "s:^#\!/bin/sh:#\!/bin/sh --login:" ${D}/opt/kde${PV}/bin/startkde > ${D}/opt/kde${PV}/bin/startkde.tmp
  mv ${D}/opt/kde${PV}/bin/startkde.tmp ${D}/opt/kde${PV}/bin/startkde
  chmod a+x ${D}/opt/kde${PV}/bin/startkde
  
  cd ${D}/usr/X11R6/bin/wm
  cp ${FILESDIR}/kde22 .
  ln -sf kde22 kde
  
  #install xsession session
  #explanation too long to put in here, mail me for info - danarmak
  insinto /usr/X11R6/bin/wm
  doins ${FILESDIR}/xsession
  cd ${D}/opt/kde${PV}/share/config/kdm
  mv kdmrc kdmrc.orig
  sed -e 's/SessionTypes=/SessionTypes=dan,/' kdmrc.orig > kdmrc
  rm kdmrc.orig
  
}


