# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-2.1.1-r1.ebuild,v 1.5 2001/06/07 01:45:52 achim Exp $

V="2.1"
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Base"
SRC_PATH="kde/stable/${PV}/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}
        >=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )"

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
    QTBASE=/usr/X11R6/lib/qt
    export CFLAGS="${CFLAGS} -I/usr/X11R6/include"
    export CXXFLAGS="${CXXFLAGS} -I/usr/X11R6/include"
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} --with-x \
		 ${myconf} \
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
}


