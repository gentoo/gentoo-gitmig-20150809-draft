# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amsynth/amsynth-1.2.0.ebuild,v 1.1 2007/03/24 23:45:35 aballier Exp $

IUSE="debug alsa jack sndfile oss"

inherit eutils autotools

MY_P=${P/_rc/-rc}
MY_P=${MY_P/amsynth/amSynth}

DESCRIPTION="amSynth stands for Analogue Modeling SYNTHesizer. It provides virtual analogue synthesis in the style of the classic Moog Minimoog/Roland Junos."
HOMEPAGE="http://amsynthe.sourceforge.net/"
SRC_URI="mirror://sourceforge/amsynthe/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-cpp/gtkmm-2.4
	sndfile? ( >=media-libs/libsndfile-1.0 )
	alsa? ( >=media-libs/alsa-lib-0.9 media-sound/alsa-utils )
	jack? ( media-sound/jack-audio-connection-kit )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-asneeded.patch"
	epatch "${FILESDIR}/${P}-cflags.patch"
	epatch "${FILESDIR}/${P}-debug.patch"
	eautoreconf
}

src_compile() {
	econf $(use_with oss) \
		$(use_with alsa) \
		$(use_with jack) \
		$(use_with sndfile) \
		$(use_enable debug) \
		|| die "configure failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	elog
	elog "amSynth has been installed normally."
	elog "If you would like to use the virtual"
	elog "keyboard option, then do"
	elog "emerge vkeybd"
	elog "and make sure you emerged amSynth"
	elog "with alsa support (USE=alsa)"
	elog
}
