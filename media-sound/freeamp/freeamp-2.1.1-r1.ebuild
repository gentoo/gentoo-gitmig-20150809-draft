# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/freeamp/freeamp-2.1.1-r1.ebuild,v 1.8 2002/08/01 14:25:57 seemant Exp $

inherit kde-functions 

DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support"
SRC_URI="http://www.freeamp.org/download/src/${P}.tar.bz2"
HOMEPAGE="http://www.freeamp.org/"
S=${WORKDIR}/freeamp

RDEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	=media-libs/freetype-1*
	sys-libs/zlib
	sys-libs/ncurses
	>=media-libs/musicbrainz-1.0.1
	X? ( virtual/x11 )
	esd? ( media-sound/esound )
	gtk? ( >=media-libs/gdk-pixbuf-0.8 )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/kdelibs )
	gnome? ( gnome-base/ORBit )
	oggvorbis? ( media-libs/libvorbis )"

DEPEND="${RDEPEND} dev-lang/nasm sys-devel/perl"

SLOT="0"
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

	into /usr ; dobin freeamp
	exeinto /usr/lib/freeamp/plugins  ; doexe plugins/*
	insinto /usr/share/freeamp/themes ; doins themes/*
	dodir /usr/share/freeamp/fonts

	dodoc AUTHORS ChangeLog CHANGES COPYING NEWS README README.linux

	cd ${D}/usr/share/freeamp ; tar zxf ${S}/help/unix/freeamphelp.tar.gz
	chown -R root.root help ; chmod 644 help/*
	dosym /usr/share/freeamp/help /usr/share/doc/${PF}/html
}
