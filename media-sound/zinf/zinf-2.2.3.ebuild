# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zinf/zinf-2.2.3.ebuild,v 1.6 2003/05/16 19:56:36 danarmak Exp $

IUSE="esd X gtk oggvorbis gnome arts"

inherit kde-functions 

S=${WORKDIR}/${P}
DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support, previously called FreeAmp"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.zinf.org/"

RDEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	sys-libs/zlib
	>=sys-libs/ncurses-5.2
	=media-libs/freetype-1* 
	>=media-libs/musicbrainz-1.0.1
	X? ( virtual/x11 ) 
	esd? ( media-sound/esound ) 
	gtk? ( >=media-libs/gdk-pixbuf-0.8 )
	gnome? ( gnome-base/ORBit )
	oggvorbis? ( media-libs/libvorbis )
	arts? ( kde-base/arts )" # doesn't work anymore? see bug #9675
	#alsa? ( media-libs/alsa-lib ) # it only supports alsa 0.5.x, so support disabled

DEPEND="$RDEPEND x86? ( dev-lang/nasm ) 
	media-libs/id3lib
	dev-lang/perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

# Unfortunately you can't selectively build a lot of the features. Therefore
# this whole package is essentially a judgement call. However, I've made the
# DEPEND in a strategic manner to ensure that your USE variable is respected
# when the knobs are *set*.

src_unpack() {

    unpack ${A}
    
#    if [ "`use arts`" ]; then
#	cd ${S}/io/arts/src
#	cp artspmo.cpp 1
#	sed -e 's:artsc/artsc.h:artsc.h:g' -e 's:artspmo.h:../include/artspmo.h:g' 1 > artspmo.cpp
#    fi

}

src_compile() {

	set-kdedir 3

	local myconf
	#use alsa || 
	myconf="${myconf} --disable-alsa"
	use esd  || myconf="${myconf} --disable-esd"
	
	if [ -n "`use arts`" ]; then
	    export ARTSCCONFIG="$KDEDIR/bin/artsc-config"
	    myconf="${myconf} --enable-arts"
	else
	    myconf="$myconf --disable-arts"
	fi

	./configure --prefix=/usr --host=${CHOST} --enable-cmdline ${myconf} || die
	make || die
	
	if [ -n "`use arts`" ]; then
	    export CPATH="${CPATH}:${KDEDIR}/include/artsc:${S}/io/arts/include"
	    cp Makefile.header 1
	    sed -e "s:ARTS_LIBS =:ARTS_LIBS = -lartsc -L${KDEDIR}/lib:" 1 > Makefile.header
	    make -f Makefile-plugins plugins/arts.pmo || die
	fi

}

src_install() {

	into /usr ; dobin zinf
	exeinto /usr/lib/zinf/plugins  ; doexe plugins/*
	insinto /usr/share/zinf/themes ; doins themes/*
	dodir /usr/share/zinf/fonts

	dodoc AUTHORS CHANGES COPYING NEWS README README.linux

}
