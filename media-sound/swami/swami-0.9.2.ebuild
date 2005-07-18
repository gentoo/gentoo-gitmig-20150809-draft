# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/swami/swami-0.9.2.ebuild,v 1.1 2005/07/18 19:55:35 fvdpol Exp $

IUSE=""
inherit eutils

DESCRIPTION="Sampled Waveforms And Musical Instruments - an advanced instrument editor for Soundfont/DLSMIDI music composition and a sampler frontend"
HOMEPAGE="http://swami.sourceforge.net/"
SRC_URI="mirror://sourceforge/swami/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/libc
	media-libs/alsa-lib
	>=x11-libs/gtk+-1.2.0
	>=media-sound/fluidsynth-1.0.4
	>=media-libs/audiofile-0.2.0
	>=media-libs/libsndfile-1.0.0
	dev-util/pkgconfig
	virtual/x11"
DEPEND="${RDEPEND}"
