# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-2.2.ebuild,v 1.3 2001/08/22 11:29:04 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Multimedia"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH
	 http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"

HOMEPAGE="http://www.kde.org"

DEPEND=">=kde-base/kdelibs-${PV}
	>=sys-libs/ncurses-5.2
        >=media-sound/cdparanoia-3.9.8
        >=media-libs/libvorbis-1.0_beta4
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	nas? ( >=media-sound/nas-1.4.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	gtk? ( >=x11-libs/gtk+-1.2.10 )
	slang? ( >=sys-libs/slang-1.4.4 )
	objprelink? ( dev-util/objprelink )"
#	tcltk? ( =dev-lang/tcl-tk.8.0.5-r2 )

RDEPEND=$DEPEND
src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    local myconf
    local myaudio
    local myinteface
    myaudio="--enable-audio=oss"
    myinterface="--enable-interface=xaw,ncurses"
    if [ -n "`use alsa`" ]
    then
      myconf="--with-alsa"
      myaudio="$myaudio,alsa"
    fi
    if [ -n "`use nas`" ]
    then
	myaudio="$myaudio,nas"
    fi
    if [ -n "`use esd`" ]
    then
	myaudio="$myaudio,esd"
    fi
    if [ -n "`use motif`" ]
    then
	myinterface="$myinterface,motif"
    fi
    if [ -n "`use gtk`" ]
    then
	myinterface="$myinterface,gtk"
    fi
# tcl tk does not work
#    if [ "`use tcltk`" ]
#    then
#	myinterface="$myinterface,tcltk"
#    fi
    if [ -n "`use slang`" ]
    then
	myinterface="$myinterface,slang"
    fi
    if [ "`use qtmt`" ]
    then
      myconf="$myconf --enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
	if [ "`use objprelink`" ] ; then
	  myconf="$myconf --enable-objprelink"
	fi
    QTBASE=/usr/X11R6/lib/qt
#    export CFLAGS="${CFLAGS/-march=i?86/}"
#    export CXXFLAGS="${CXXFLAGS/-march=i?86/}"
#    unset CFLAGS
#    unset CXXFLAGS
    try ./configure --prefix=${KDEDIR} --host=${CHOST} \
		--with-qt-dir=$QTBASE --with-xinerama \
		$myconf $myaudio $myinterface
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COPYING README*
}







