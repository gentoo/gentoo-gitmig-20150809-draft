# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.2.1.ebuild,v 1.3 2001/09/29 21:03:26 danarmak Exp $
# NOTE: Now we install into /usr
# ANOTHER NOTE: we now rely on env.d to provide KDEDIR and QTDIR settings,
# instead of hardconding them here

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Libraries"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=sys-devel/gcc-2.95.2  sys-devel/perl
	>=media-libs/audiofile-0.1.9
	>=x11-libs/qt-x11-2.3.0
        >=sys-apps/bzip2-1.0.1
	>=dev-libs/libpcre-3.4
	>=gnome-libs/libxml2-2.4.1
	ssl? ( >=dev-libs/openssl-0.9.6 )
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	cups? ( net-print/cups )
	objprelink? ( dev-util/objprelink )
	sys-devel/autoconf"

RDEPEND=">=sys-devel/gcc-2.95.2
	 >=media-libs/audiofile-0.1.9
         >=media-libs/tiff-3.5.5
         >=sys-apps/bzip2-1.0.1
	 >=dev-libs/libpcre-3.4
	 >=x11-libs/qt-x11-2.3.0
         ~kde-base/kde-env-${PV}
         app-text/sgml-common
         alsa? ( >=media-libs/alsa-lib-0.5.9 )
	 cups? ( net-print/cups )
         ssl? ( >=dev-libs/openssl-0.9.6 )
	 sys-devel/perl
	 dev-lang/python"

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	cd ${S}

}

src_compile() {

    local myopts
    if [ "`use ssl`" ] ; then
      myopts="--with-ssl-dir=/usr"
    else
      myopts="--without-ssl"
    fi
    if [ "`use alsa`" ] ; then
      myopts="$myopts --with-alsa"
    fi
    if [ -z "`use cups`" ] ; then
      myopts="$myopts --disable-cups"
    fi
    if [ "`use qtmt`" ] ; then
      myopts="$myopts --enable-mt"
    fi
      myopts="$myopts --with-ipv6-lookup=no"
    fi
    if [ "`use objprelink`" ] ; then
	myopts="$myopts --enable-objprelink"
    fi

    ./configure --host=${CHOST} \
	$myopts --with-xinerama --disable-libfam || die
    make || die
}

src_install() {
  make install DESTDIR=${D} || die
  dodoc AUTHORS ChangeLog COMPILING COPYING* NAMING NEWS README
  docinto html
  dodoc *.html
}


