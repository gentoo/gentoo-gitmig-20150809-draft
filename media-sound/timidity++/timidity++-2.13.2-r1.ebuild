# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.13.2-r1.ebuild,v 1.3 2005/03/25 19:30:50 lanius Exp $

IUSE="oss nas esd motif X gtk gtk2 oggvorbis tcltk slang alsa arts jack portaudio emacs ao speex flac ncurses"

inherit gnuconfig eutils

MY_PV=${PV/_/-}
MY_P=TiMidity++-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
HOMEPAGE="http://timidity.sourceforge.net/"
SRC_URI="mirror://sourceforge/timidity/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="ncurses? ( >=sys-libs/ncurses-5.0 )
	gtk? ( 	gtk2? ( >=x11-libs/gtk+-2.0 )
		!gtk2? ( =x11-libs/gtk+-1.2* ) )
	tcltk? ( >=dev-lang/tk-8.1 )
	motif? ( x11-libs/openmotif )
	esd? ( >=media-sound/esound-0.2.22 )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( media-libs/alsa-lib )
	slang? ( >=sys-libs/slang-1.4 )
	arts? ( kde-base/arts )
	jack? ( media-sound/jack-audio-connection-kit )
	portaudio? ( !ppc? ( media-libs/portaudio ) )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	flac? ( >=media-libs/flac-1.1.0 )
	speex? ( >=media-libs/speex-1.1.5 )
	ao? ( >=media-libs/libao-0.8.5 )"

DEPEND="${RDEPEND}
	sys-devel/autoconf"

RDEPEND="${RDEPEND}
	emacs? ( virtual/emacs )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gtk26.patch
	# fix header location of speex
	sed -i -e "s:#include <speex:#include <speex/speex:g" configure* timidity/speex_a.c
}

src_compile() {
	local myconf
	local audios

	use flac && audios="${audios},flac"
	use speex && audios="${audios},speex"
	use oggvorbis && audios="${audios},vorbis"

	use oss && audios="${audios},oss"
	use esd && audios="${audios},esd"
	use arts && audios="${audios},arts"
	use jack && audios="${audios},jack"
	use portaudio && use !ppc && audios="${audios},portaudio"
	use ao && audios="${audios},ao"

	if use nas; then
		audios="${audios},nas"
		myconf="${myconf} --with-nas-library=/usr/$(get_libdir)/libaudio.so"
	fi

	if use alsa; then
		audios="${audios},alsa"
		myconf="${myconf} --with-default-output=alsa --enable-alsaseq"
	fi

	econf \
		--localstatedir=/var/state/timidity++ \
		--with-elf \
		--enable-audio=${audios} \
		--enable-server \
		--enable-network \
		--enable-dynamic \
		--enable-vt100 \
		$(use_enable emacs) \
		$(use_enable slang) \
		$(use_enable ncurses) \
		$(use_with X x) \
		$(use_enable X spectrogram) \
		$(use_enable X wrd) \
		$(use_enable X xskin) \
		$(use_enable X xaw) \
		$(use_enable gtk) \
		$(use_enable motif) \
		$(use_enable tcltk) \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog* INSTALL*
	dodoc NEWS README* ${FILESDIR}/timidity.cfg

	newconfd ${FILESDIR}/conf.d.timidity timidity
	newinitd ${FILESDIR}/init.d.timidity timidity

	insinto /etc
	newins ${FILESDIR}/timidity.cfg-r1 timidity.cfg

	dodir /usr/share/timidity
	dosym /etc/timidity.cfg /usr/share/timidity/timidity.cfg

	newbin ${FILESDIR}/timidity-update timidity-update

	if use emacs ; then
		dosed 's:/usr/local/bin/timidity:/usr/bin/timidity:g' /usr/share/emacs/site-lisp/timidity.el
	else
		rm ${D}/timidity.el
	fi
}

pkg_postinst() {
	einfo ""
	einfo "A timidity config file has been installed in /etc/timidity.cfg."
	einfo ""
	einfo "Do not edit this file as it will interfere with the timidity-update tool."
	einfo "You will need to emerge timidity-eawpatches or timidity-shompatches."
	einfo ""
	einfo "The tool 'timidity-update' can be used to switch between installed patchsets."
	einfo ""
	einfo "An init script for the alsa timidity sequencer has been installed."
	einfo "If you wish to use the timidity virtual sequencer, edit /etc/conf.d/timidity"
	einfo "and run 'rc-update add timidity <runlevel> && /etc/init.d/timidity start'"

	if use sparc; then
		ewarn "sparc support is experimental. oss, alsa, esd, and portaudio do not work."
		ewarn "-Ow (save to wave file) does..."
	fi
}
