# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-2.2.1.ebuild,v 1.5 2001/09/29 21:03:25 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Base"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND="~kde-base/kdelibs-${PV}
        >=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	lame? ( =media-sound/lame-3.89b )
	vorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	objprelink? ( dev-util/objprelink )"

src_unpack() {
	
	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	
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

    if [ -z "`use motif`" ] ; then
      myconf="$myconf --without-motif"
    fi

    if [ -z "`use lame`" ] ; then
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

    ./configure --host=${CHOST} --with-x \
		 ${myconf} --with-xinerama || die
    make || die
}


src_install() {

  cd ${S}

  make install DESTDIR=${D} || die

  insinto /etc/pam.d
  newins ${FILESDIR}/kscreensaver.pam kscreensaver
  newins kde.pamd kde

  dodoc AUTHORS ChangeLog README*
  sed -e "s:^#\!/bin/sh:#\!/bin/sh --login:" ${D}/usr/bin/startkde > ${D}/usr/bin/startkde.tmp
  mv ${D}/usr/bin/startkde.tmp ${D}/usr/bin/startkde
  chmod a+x ${D}/usr/bin/startkde

  exeinto /usr/X11R6/bin/wm
  doexe ${FILESDIR}/{kde${PV},xsession}
  cd ${D}/usr/X11R6/bin/wm
  ln -sf kde${PV} kde

  cd ${D}/usr/share/config/kdm
  mv kdmrc kdmrc.orig
  sed -e 's/SessionTypes=/SessionTypes=xsession,/' kdmrc.orig > kdmrc
  rm kdmrc.orig
  
}


