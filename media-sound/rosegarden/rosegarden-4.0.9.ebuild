# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-4.0.9.ebuild,v 1.10 2004/06/13 08:39:47 eradicator Exp $

IUSE=""

MY_P=${P/\./-}
DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.all-day-breakfast.com/rosegarden/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=kde-base/kdelibs-3.0
	kde-base/kdemultimedia
	>=x11-libs/qt-3
	virtual/alsa
	media-sound/jack-audio-connection-kit
	>=media-libs/ladspa-sdk-1.0
	>=media-libs/ladspa-cmt-1.14"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
		--with-jack \
		--with-ladspa \
		|| die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
}
