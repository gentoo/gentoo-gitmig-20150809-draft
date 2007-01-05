# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amsynth/amsynth-1.1.0.ebuild,v 1.2 2007/01/05 17:21:41 flameeyes Exp $

IUSE="oss alsa jack"

inherit eutils

MY_P=${P/_rc/-rc}
MY_P=${MY_P/amsynth/amSynth}

DESCRIPTION="amSynth stands for Analogue Modeling SYNTHesizer. It provides virtual analogue synthesis in the style of the classic Moog Minimoog/Roland Junos."
HOMEPAGE="http://amsynthe.sourceforge.net/"
SRC_URI="mirror://sourceforge/amsynthe/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

# libsndfile support is actually optional, but IMHO this package should have it
DEPEND=">=dev-cpp/gtkmm-2.4
	>=media-libs/libsndfile-1.0
	alsa? ( >=media-libs/alsa-lib-0.9 media-sound/alsa-utils )
	jack? ( media-sound/jack-audio-connection-kit )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	econf `use_with oss` `use_with alsa` `use_with jack` || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
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
