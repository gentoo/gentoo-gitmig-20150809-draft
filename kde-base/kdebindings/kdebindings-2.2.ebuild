# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

V=2.2
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${V} - SDK"
SRC_PATH="kde/stable/${V}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdebase-${V}
	>=x11-libs/gtk+-1.2.10
	sys-devel/perl 
	python? ( dev-lang/python )
	java? (	dev-lang/jdk )"

RDEPEND=$DEPEND

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
     local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    if [ -z "`use python`" ] ; then
      myconf="$myconf --without-python"
    fi
    if [ "`use java`" ] ; then
      myconf="$myconf --with-java=/opt/java"
    else
      myconf="$myconf --without-java"
    fi
    try ./configure --prefix=$KDEDIR --host=${CHOST} \
		--with-qt-dir=$QTBASE --with-xinerama $myconf
    try make LIBPYTHON=\"`python-config`\"
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README
}



