# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.12.0.ebuild,v 1.2 2002/07/11 06:30:41 drobbins Exp $

PN=TiMidity++-${PV}
S=${WORKDIR}/TiMidity++-2.12.0-pre1
DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
SRC_URI="http://www.goice.co.jp/member/mo/timidity/dist/TiMidity++-2.12.0-pre1.tar.bz2"
HOMEPAGE="http://www.goice.co.jp/member/mo/timidity/"

DEPEND=">=sys-libs/ncurses-5.0
	X? ( >=x11-base/xfree-4.0 )
	motif? ( >=x11-libs/openmotif-2.1 )
	tcltk? ( >=dev-lang/tk-8.1 )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( media-libs/alsa-lib )
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( =x11-libs/gtk+-1.2* )
	slang? ( >=sys-libs/slang-1.4 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
	local myconf
	local audios
	local interfaces
	
	interfaces="dynamic,ncurses,emacs,vt100"
	#audios="oss"
	
	use X	\
		&& myconf="${myconf} --with-x"	\
		&& interfaces="${interfaces},xskin,xaw"	\
		|| myconf="${myconf} --without-x"

	use slang && interfaces="${interfaces},slang"
	use gtk && interfaces="${interfaces},gtk"
	use motif && interfaces="${interfaces},motif"

	use alsa	\
		&& audios="${audios},alsa"	\
		&& interfaces="${interfaces},alsaseq"	\
		&& myconf="${myconf} --with-default-output=alsa"

	use esd && audios="${audios},esd"
	use oggvorbis && audios="${audios},vorbis"
	use nas && audios="${audios},nas"
		
	./configure 	\
		--prefix=/usr	\
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/state/timidity++ \
		--host=${CHOST}	\
		--target=${CHOST} \
		--build=${CHOST} \
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
