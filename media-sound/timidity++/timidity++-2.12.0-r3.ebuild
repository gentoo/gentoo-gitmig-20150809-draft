# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.12.0-r3.ebuild,v 1.7 2003/12/26 23:38:40 weeve Exp $

MY_P=TiMidity++-${PV}-pre1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
HOMEPAGE="http://www.goice.co.jp/member/mo/timidity/"
SRC_URI="http://www.goice.co.jp/member/mo/timidity/dist/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="oss nas esd motif X gtk oggvorbis tcltk slang alsa"
inherit gnuconfig

DEPEND=">=sys-libs/ncurses-5.0
	X? ( >=x11-base/xfree-4.0 )
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( =x11-libs/gtk+-1.2* )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( media-libs/alsa-lib )
	motif? ( >=x11-libs/openmotif-2.1 )
	slang? ( >=sys-libs/slang-1.4 )
	tcltk? ( >=dev-lang/tk-8.1 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	sys-devel/autoconf"

src_compile() {
	local myconf
	local audios
	local interfaces

	use amd64 && ( epatch ${FILESDIR}/gnuconfig_update.patch
		epatch ${FILESDIR}/long-64bit.patch
		gnuconfig_update )

	interfaces="dynamic,ncurses,emacs,vt100"
	if [ "`use oss`" ]; then \
		audios="oss";
	fi

	use X \
		&& myconf="${myconf} --with-x \
			--enable-spectrogram --enable-wrd" \
		&& interfaces="${interfaces},xskin,xaw" \
		|| myconf="${myconf} --without-x "

	use slang && interfaces="${interfaces},slang"
	if [ "`use X`" ]; then \
		use gtk && interfaces="${interfaces},gtk";
	fi
	if [ "`use X`" ]; then \
		use motif && interfaces="${interfaces},motif";
	fi

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
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodir /usr/share/timidity/config
	insinto /usr/share/timidity/config
	doins ${FILESDIR}/timidity.cfg
	dodoc AUTHORS COPYING ChangeLog* INSTALL*
	dodoc NEWS README*
}

pkg_postinst () {
	einfo ""
	einfo "A timidity config file has been installed in"
	einfo "/usr/share/timitidy/config/timidity.cfg. This"
	einfo "file must to copied into /usr/share/timidity/"
	einfo "and edited to match your configuration."
	einfo ""
}
