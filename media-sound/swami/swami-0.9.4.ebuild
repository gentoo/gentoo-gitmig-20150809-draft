# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/swami/swami-0.9.4.ebuild,v 1.2 2007/07/02 15:19:20 peper Exp $

IUSE="alsa"

inherit eutils

DESCRIPTION="Sampled Waveforms And Musical Instruments - is an instrument editor for MIDI music composition and a sampler frontend"
HOMEPAGE="http://swami.sourceforge.net/"
SRC_URI="http://ovh.dl.sourceforge.net/sourceforge/swami/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"

# Swami plugins must not be stripped of symbols, so we handle it manually.
RESTRICT="strip"

RDEPEND="
	>=x11-libs/gtk+-1.2.10-r11
	>=media-sound/fluidsynth-1.0.4
	>=media-libs/audiofile-0.2.0-r1
	>=media-libs/libsndfile-1.0.0
	dev-util/pkgconfig
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf || die "./configure failed"
	emake || die "parallel make failed"
}

src_install() {
	cd ${S}
	make DESTDIR="${D}" PREFIX=/usr install || die "install failed"
}
