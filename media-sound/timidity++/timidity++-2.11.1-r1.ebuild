# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.11.1-r1.ebuild,v 1.3 2002/05/23 06:50:14 seemant Exp $

PN=TiMidity++-${PV}
S=${WORKDIR}/${PN}
DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
SRC_URI="http://www.goice.co.jp/member/mo/timidity/dist/${PN}.tar.bz2"
HOMEPAGE="http://www.goice.co.jp/member/mo/timidity/"

DEPEND=">=sys-libs/ncurses-5.0
	X? ( >=x11-base/xfree-4.0 )
	motif? ( >=x11-libs/openmotif-2.1 )
	tcltk? ( >=dev-lang/tk-8.1 )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( >=media-libs/alsa-lib-0.5.10 )
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( =x11-libs/gtk+-1.2* )
	slang? ( >=sys-libs/slang-1.4 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

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
	[ "`use slang`" ] && interfaces="${interfaces},slang"
	[ "`use gtk`" ] && interfaces="${interfaces},gtk"
	[ "`use motif`" ] && interfaces="${interfaces},motif"
	if [ "`use alsa`" ]
	then
		audios="${audios},alsa"
		interfaces="${interfaces},alsaseq"
		myconf="${myconf} --with-default-output=alsa"
	fi
	[ "`use esd`" ] && audios="${audios},esd"
	[ "`use oggvorbis`" ] && audios="${audios},vorbis"
	[ "`use nas`" ] && audios="${audios},nas"
		
	./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man\
	--with-elf \
	--enable-audio=${audios} \
	--enable-interface=${interfaces} \
	--enable-server --enable-network \
	--enable-spectrogram --enable-wrd \
	${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* INSTALL*
	dodoc NEWS README*
}
