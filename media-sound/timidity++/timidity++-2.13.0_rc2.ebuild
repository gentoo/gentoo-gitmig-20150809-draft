# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.13.0_rc2.ebuild,v 1.6 2004/04/03 23:55:13 spyderous Exp $

MY_PV=${PV/_/-}
MY_P=TiMidity++-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
HOMEPAGE="http://timidity.sourceforge.net/"
SRC_URI="mirror://sourceforge/timidity/${MY_P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="oss nas esd motif X gtk oggvorbis tcltk slang alsa kde jack portaudio"

inherit gnuconfig

RDEPEND=">=sys-libs/ncurses-5.0
	X? ( virtual/x11 )
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( =x11-libs/gtk+-1.2* )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( media-libs/alsa-lib )
	motif? ( >=x11-libs/openmotif-2.1 )
	slang? ( >=sys-libs/slang-1.4 )
	tcltk? ( >=dev-lang/tk-8.1 )
	kde? ( kde-base/arts )
	jack? ( !sparc? ( virtual/jack ) )
	portaudio? ( !ppc? ( media-libs/portaudio ) )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_compile() {
	local myconf
	local audios
	local interfaces

	interfaces="dynamic,ncurses,emacs,vt100"

	if use X; then
		myconf="${myconf} --with-x --enable-spectrogram --enable-wrd"
		interfaces="${interfaces},xskin,xaw"
		use gtk && interfaces="${interfaces},gtk"
		use motif && interfaces="${interfaces},motif"
	else
		myconf="${myconf} --without-x"
	fi

	use slang && interfaces="${interfaces},slang"

	use oss && audios="${audios},oss"
	use esd && audios="${audios},esd"
	use oggvorbis && audios="${audios},vorbis"
	use nas && audios="${audios},nas"
	use kde && audios="${audios},arts"
	use sparc || (use jack && audios="${audios},jack")
	(use x86 || use sparc) && use portaudio && audios="${audios},portaudio"

	use alsa \
		&& audios="${audios},alsa" \
		&& interfaces="${interfaces},alsaseq" \
		&& myconf="${myconf} --with-default-output=alsa"

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

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d.timidity timidity

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.timidity timidity
}

pkg_postinst () {
	einfo ""
	einfo "A timidity config file has been installed in"
	einfo "/usr/share/timitidy/config/timidity.cfg. This"
	einfo "file must to copied into /usr/share/timidity/"
	einfo "and edited to match your configuration."
	einfo ""
	einfo "An init script for the alsa timidity sequencer has been installed."
	einfo "If you wish to use the timidity virtual sequencer, edit /etc/conf.d/timidity"
	einfo "and run 'rc-update add timidity <runlevel> && /etc/init.d/timidity start'"
}
