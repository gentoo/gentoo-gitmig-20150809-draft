# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-2.2.1.ebuild,v 1.1 2001/09/19 06:24:04 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Multimedia"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

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

	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff

}

src_compile() {
    . /etc/env.d/90{kde${PV},qt}
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
    ./configure --host=${CHOST} \
		--with-xinerama \
		$myconf $myaudio $myinterface || die
    make || die
}

src_install() {
  make install DESTDIR=${D} || die
  dodoc AUTHORS ChangeLog COPYING README*
}







