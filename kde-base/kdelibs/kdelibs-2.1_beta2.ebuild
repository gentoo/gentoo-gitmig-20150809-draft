# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.1_beta2.ebuild,v 1.1 2001/01/30 21:58:32 achim Exp $

V=2.1-beta2
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE 2.1 Beta 2 - libs"
SRC_PATH="kde/unstable/distribution/2.1beta2/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=sys-devel/gcc-2.95.2
	>=media-libs/audiofile-0.1.9
	>=media-libs/tiff-3.5.5
	>=x11-libs/qt-x11-2.2.3
	ssl? ( >=dev-libs/openssl-0.9.6 )
	mysql? ( >=dev-db/mysql-3.23.30 )
	postgres? ( >=dev-db/postgresql-7.0.3 )"

RDEPEND=">=sys-devel/gcc-2.95.2
	 >=media-libs/audiofile-0.1.9
	 >=x11-libs/qt-x11-2.2.3"

src_unpack() {
  unpack ${A}
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
    export myopts
    cp configure configure.orig
    sed -e "s:^DO_NOT_COMPILE=\"\$DO_NOT_COMPILE kdedb\"::" \
    configure.orig > configure
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} \
		--with-qt-dir=$QTBASE --with-alsa $myopts
    for i in kdb kdbcore kdbui plugins plugins/mysql plugins/postgres
    do
      cd ${S}/kdedb/$i
      cp Makefile Makefile.orig
      sed -e "s:^all_includes = :all_includes = -I\$\(top_srcdir\)/kio :" \
	  -e "s:^MYSQL_LIBDIR.*$:MYSQL_LIBDIR = /usr/lib:" \
	Makefile.orig > Makefile
    done
    cd ${S}
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COMPILING COPYING* NAMING NEWS README
  docinto html
  dodoc *.html
}


