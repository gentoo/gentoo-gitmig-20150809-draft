# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings/kdebindings-2.2.ebuild,v 1.4 2001/09/29 21:03:26 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Bindings"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH
	 http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdebase-${PV}
	>=x11-libs/gtk+-1.2.10
	sys-devel/perl 
	python? ( dev-lang/python )
	java? (	dev-lang/jdk )
  	objprelink? ( dev-util/objprelink )"

RDEPEND=$DEPEND

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	cd ${S}
	use objprelink && patch -p0 < ${DISTDIR}/kde-admin-acinclude.patch

}

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
     local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ -z "`use python`" ] ; then
      myconf="$myconf --without-python"
    fi
    if [ "`use java`" ] ; then
      myconf="$myconf --with-java=/opt/java"
    else
      myconf="$myconf --without-java"
    fi
	if [ "`use objprelink`" ] ; then
	  myconf="$myconf --enable-objprelink"
	fi
    try ./configure --prefix=$KDEDIR --host=${CHOST} \
		--with-qt-dir=$QTBASE --with-xinerama $myconf
    try make LIBPYTHON=\"`python-config`\"
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README
}



