# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.12.0.ebuild,v 1.9 2004/02/01 13:32:34 ferringb Exp $

MY_P=TiMidity++-${PV}-pre1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
HOMEPAGE="http://www.goice.co.jp/member/mo/timidity/"
SRC_URI="http://www.goice.co.jp/member/mo/timidity/dist/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nas esd motif X gtk oggvorbis tcltk slang alsa"

DEPEND=">=sys-libs/ncurses-5.0
	X? ( >=x11-base/xfree-4.0 )
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( =x11-libs/gtk+-1.2* )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( media-libs/alsa-lib )
	motif? ( >=x11-libs/openmotif-2.1 )
	slang? ( >=sys-libs/slang-1.4 )
	tcltk? ( >=dev-lang/tk-8.1 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-alsalib-fix.patch || die "Alsalib-1.0 patch failed"
}

src_compile() {
	local myconf
	local audios
	local interfaces

	interfaces="dynamic,ncurses,emacs,vt100"
	#audios="oss"

	use X \
		&& myconf="${myconf} --with-x" \
		&& interfaces="${interfaces},xskin,xaw" \
		|| myconf="${myconf} --without-x"

	use slang && interfaces="${interfaces},slang"
	use gtk && interfaces="${interfaces},gtk"
	use motif && interfaces="${interfaces},motif"

	use alsa \
		&& audios="${audios},alsa" \
		&& interfaces="${interfaces},alsaseq" \
		&& myconf="${myconf} --with-default-output=alsa"

	use esd && audios="${audios},esd"
	use oggvorbis && audios="${audios},vorbis"
	use nas && audios="${audios},nas"

	econf \
		--localstatedir=/var/state/timidity++ \
		--with-elf \
		--enable-audio=${audios} \
		--enable-interface=${interfaces} \
		--enable-server \
		--enable-network \
		--enable-spectrogram \
		--enable-wrd \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* INSTALL*
	dodoc NEWS README*
}
