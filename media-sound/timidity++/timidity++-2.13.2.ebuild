# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.13.2.ebuild,v 1.13 2006/02/19 02:10:33 chainsaw Exp $

inherit eutils

MY_PV=${PV/_/-}
MY_P=TiMidity++-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
HOMEPAGE="http://timidity.sourceforge.net/"
SRC_URI="mirror://sourceforge/timidity/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc sparc x86"
IUSE="oss nas esd motif X gtk vorbis tcltk slang alsa arts jack portaudio emacs"

RDEPEND=">=sys-libs/ncurses-5.0
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( =x11-libs/gtk+-1.2* )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( media-libs/alsa-lib )
	motif? ( virtual/motif )
	slang? ( >=sys-libs/slang-1.4 )
	arts? ( kde-base/arts )
	jack? ( media-sound/jack-audio-connection-kit )
	portaudio? ( !ppc? ( media-libs/portaudio ) )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

DEPEND="${RDEPEND}
	sys-devel/autoconf"

RDEPEND="${RDEPEND}
	X? ( tcltk? ( >=dev-lang/tk-8.1 ) )
	emacs? ( virtual/emacs )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gtk26.patch
}

src_compile() {
	local myconf
	local audios
	local interfaces

	interfaces="dynamic,ncurses,emacs,vt100"

	if use X ; then
		myconf="${myconf} --with-x --enable-spectrogram --enable-wrd"
		interfaces="${interfaces},xskin,xaw"
		# wrapping in a "use arts" because of bug #48761
		use arts || use gtk && interfaces="${interfaces},gtk"
		use motif && interfaces="${interfaces},motif"
	else
		myconf="${myconf} --without-x"
	fi

	use slang && interfaces="${interfaces},slang"

	use oss && audios="${audios},oss"
	use esd && audios="${audios},esd"
	use vorbis && audios="${audios},vorbis"
	use nas && { audios="${audios},nas"; myconf="${myconf} --with-nas-library=/usr/X11R6/$(get_libdir)/libaudio.so"; }
	use arts && audios="${audios},arts"
	use jack && audios="${audios},jack"
	use portaudio && use !ppc && audios="${audios},portaudio"

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

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog*
	dodoc NEWS README* ${FILESDIR}/timidity.cfg

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d.timidity timidity

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.timidity timidity

	insinto /etc
	newins ${FILESDIR}/timidity.cfg-r1 timidity.cfg

	dodir /usr/share/timidity
	dosym /etc/timidity.cfg /usr/share/timidity/timidity.cfg

	exeinto /usr/bin
	newexe ${FILESDIR}/timidity-update timidity-update

	if use emacs ; then
		dosed 's:/usr/local/bin/timidity:/usr/bin/timidity:g' /usr/share/emacs/site-lisp/timidity.el
	else
		rm ${D}/timidity.el
	fi
}

pkg_postinst() {
	einfo
	einfo "A timidity config file has been installed in /etc/timidity.cfg."
	einfo
	einfo "Do not edit this file as it will interfere with the timidity-update tool."
	einfo "You will need to emerge timidity-eawpatches or timidity-shompatches."
	einfo
	einfo "The tool 'timidity-update' can be used to switch between installed patchsets."
	einfo
	einfo "An init script for the alsa timidity sequencer has been installed."
	einfo "If you wish to use the timidity virtual sequencer, edit /etc/conf.d/timidity"
	einfo "and run 'rc-update add timidity <runlevel> && /etc/init.d/timidity start'"

	if use sparc; then
		ewarn "sparc support is experimental. oss, alsa, esd, and portaudio do not work."
		ewarn "-Ow (save to wave file) does..."
	fi
}
