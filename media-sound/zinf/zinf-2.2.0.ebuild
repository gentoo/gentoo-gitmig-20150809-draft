# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/zinf/zinf-2.2.0.ebuild,v 1.6 2002/07/27 10:44:31 seemant Exp $

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
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	gnome? ( gnome-base/ORBit )
	oggvorbis? ( media-libs/libvorbis )"

DEPEND="dev-lang/nasm 
sys-devel/perl"


LICENSE="GPL-2"
KEYWORDS="x86"

# Unfortunately you can't selectively build a lot of the features. Therefore
# this whole package is essentially a judgement call. However, I've made the
# DEPEND in a strategic manner to ensure that your USE variable is respected
# when the knobs are *set*.

src_unpack() {

    unpack ${A}
    
    if [ "`use arts`" ]; then
	cd ${S}/io/arts/src
	cp artspmo.cpp 1
	sed -e 's:artsc/artsc.h:artsc.h:g' 1 > artspmo.cpp
    fi

}

src_compile() {

	if [ -n "`which artsc-config`" ]; then
	    ARTSPREFIX="`artsc-config --arts-prefix`"
	else
	    ARTSPREFIX="/usr/kde/3"
	fi

	local myconf
	use alsa || myconf="${myconf} --disable-alsa"
	use esd  || myconf="${myconf} --disable-esd"
	use arts && myconf="${myconf} --with-extra-includes=${ARTSPREFIX}/include"

	./configure --prefix=/usr --host=${CHOST} ${myconf} || die
	make ; assert "compile problem :("
}

src_install() {

	into /usr ; dobin zinf
	exeinto /usr/lib/zinf/plugins  ; doexe plugins/*
	insinto /usr/share/zinf/themes ; doins themes/*
	dodir /usr/share/zinf/fonts

	dodoc AUTHORS CHANGES COPYING NEWS README README.linux

}
