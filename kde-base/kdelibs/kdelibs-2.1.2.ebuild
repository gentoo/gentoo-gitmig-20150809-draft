# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.1.2.ebuild,v 1.3 2001/06/07 01:45:52 achim Exp

V=2.1
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - libs"
SRC_PATH="kde/stable/${PV}/distribution/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=sys-devel/gcc-2.95.2  sys-devel/perl
	>=media-libs/audiofile-0.1.9
	>=x11-libs/qt-x11-2.3.0
        >=sys-apps/bzip2-1.0.1
	>=dev-libs/libpcre-3.4
	ssl? ( >=dev-libs/openssl-0.9.6 )
	mysql? ( >=dev-db/mysql-3.23.30 )
	postgres? ( >=dev-db/postgresql-7.0.3 )
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	sys-devel/autoconf"

RDEPEND=">=sys-devel/gcc-2.95.2
	 >=media-libs/audiofile-0.1.9
         >=media-libs/tiff-3.5.5
         >=sys-apps/bzip2-1.0.1
	 >=dev-libs/libpcre-3.4
	 >=x11-libs/qt-x11-2.3.0
         >=kde-base/kde-env-2.1-r1
         app-text/sgml-common
         alsa? ( >=media-libs/alsa-lib-0.5.9 )
         ssl? ( >=dev-libs/openssl-0.9.6 )"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/${PN}-2.1.1-ksgmltools-gentoo.diff
    rm configure
    autoconf
}

src_compile() {

    QTBASE=/usr/X11R6/lib/qt

    local myopts
    if [ "`use ssl`" ]
    then
      myopts="--with-ssl-dir=/usr"
    else
      myopts="--without-ssl"
    fi
    if [ "`use mysql`" ]
    then
      myopts="$myopts --enable-mysql "
    else
      myopts="$myopts --disable-mysql"
    fi
    if [ "`use postgres`" ]
    then
      myopts="$myopts --enable-pgsql"
    else
      myopts="$myopts --disable-pgsql"
    fi
    if [ "`use alsa`" ]
    then
      myopts="$myopts --with-alsa"
    fi
    if [ "`use qtmt`" ]
    then
      myopts="$myopts --enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myopts="$myopts --enable-mitshm"
    fi
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} \
		--with-qt-dir=$QTBASE $myopts
    cd ${S}
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COMPILING COPYING* NAMING NEWS README
  docinto html
  dodoc *.html
}


pkg_postinst() {
     if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
      install-catalog --add /etc/sgml/kde-docbook.cat /usr/share/sgml/docbook/kde-customizations/catalog
      install-catalog --add /etc/sgml/kde-docbook.cat /etc/sgml/sgml-docbook.cat
    fi
}

pkg_prerm() {
    if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
      if [ -e "/etc/sgml/kde-docbook.cat" ] ; then
        install-catalog --remove /etc/sgml/kde-docbook.cat /usr/share/sgml/docbook/kde-customizations/catalog
        install-catalog --remove /etc/sgml/kde-docbook.cat /etc/sgml/sgml-docbook.cat
      fi
    fi
}
