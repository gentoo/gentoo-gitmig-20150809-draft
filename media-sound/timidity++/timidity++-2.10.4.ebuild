# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.10.4.ebuild,v 1.1 2001/05/22 15:16:33 pete Exp $

#P=
A=TiMidity++-${PV}.tar.bz2
S=${WORKDIR}/TiMidity++-${PV}
DESCRIPTION=""
SRC_URI="http://www.goice.co.jp/member/mo/timidity/dist/TiMidity++-${PV}.tar.bz2"
HOMEPAGE="http://www.goice.co.jp/member/mo/timidity/"

DEPEND=">=sys-libs/ncurses-5.0
	X? ( >=x11-base/xfree-4.0 )
	motif? ( >=x11-libs/openmotif-2.1 )
	tcltk? ( >=dev-lang/tcl-tk-8.1 )
	nas? ( >=media-sound/nas-1.4 )
	alsa? ( >=media-libs/alsa-lib-0.5.10 )
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( >=x11-libs/gtk+-1.2.8 )
	slang? ( >=sys-libs/slang-1.4 )
	ogg? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
    local myconf
    local audios
    local interfaces
    
    interfaces="dynamic,ncurses,emacs,vt100"
    audios="oss"
    
    if [ "`use X`" ]
    then
	myconf="${myconf} --with-x"
	interfaces="${interfaces},xskin,xaw"
    else
	myconf="${myconf} --without-x"
    fi
    if [ "`use slang`" ]
    then
	interfaces="${interfaces},slang"
    fi
    if [ "`use gtk`" ]
    then
	interfaces="${interfaces},gtk"
    fi
    if [ "`use motif`" ]
    then
	interfaces="${interfaces},motif"
    fi
    if [ "`use alsa`" ]
    then
	audios="${audios},alsa"
	interfaces="${interfaces},alsaseq"
	myconf="${myconf} --with-default-output=alsa"
    fi
    if [ "`use esd`" ]
    then
	audios="${audios},esd"
    fi
    if [ "`use ogg`" ]
    then
	audios="${audios},vorbis"
    fi
    if [ "`use nas`" ]
    then
	audios="${audios},nas"
    fi
        
    try ./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man\
	--with-elf \
	--enable-audio=${audios} \
	--enable-interface=${interfaces} \
	--enable-server --enable-network \
	--enable-spectrogram --enable-wrd \
	${myconf}
    try make
}

src_install () {
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog* INSTALL*
    dodoc NEWS README*
}
