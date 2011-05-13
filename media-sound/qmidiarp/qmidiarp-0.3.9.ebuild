# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmidiarp/qmidiarp-0.3.9.ebuild,v 1.2 2011/05/13 14:44:41 angelos Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="An arpeggiator, sequencer and MIDI LFO for ALSA"
HOMEPAGE="http://qmidiarp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldadd.patch
	eautomake
}
