# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-2.1.1_beta1.ebuild,v 1.2 2001/05/12 12:13:25 achim Exp $

P=${PN}-1.1-beta1
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - KOffice"
SRC_PATH="kde/unstable/${P}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-2.1.1
	>=dev-lang/python-2.0-r2"

RDEPEND=$DEPEND

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=$KDEDIR --host=${CHOST} \
		--with-qt-dir=$QTBASE
   if [ "`use readline`" ]
   then
     LIBPYTHON="-lpython2.0 -lm -lutil -ldl -lz -lreadline -lncurses -lcrypt"
   fi
   if [ "`use berkdb`" ]
   then
     LIBPYTHON="$LIBPYTHON -L/usr/lib -ldb-3.2"
   fi
   echo $LIBPYTHON
   # I use sed to patch a makefile to compile with python
        for i in connector text zoom selector
        do
            cd ${S}/kivio/plugins/kivio${i}tool
            cp Makefile Makefile.orig
            sed -e "s:^LDFLAGS =.*:LDFLAGS = $LIBPYTHON:" Makefile.orig > Makefile
        done
   cd ${S}

   try LIBPYTHON=\"$LIBPYTHON\" make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc ChangeLog COPYING AUTHORS NEWS README
}

