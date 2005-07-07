# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-4.0.9.8.ebuild,v 1.9 2005/07/07 04:43:44 caleb Exp $

MY_PV="${PV/./-}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="jack"

DEPEND=">=kde-base/kdelibs-3.0
	|| ( kde-base/kdemultimedia-meta kde-base/kdemultimedia )
	=x11-libs/qt-3*
	virtual/alsa
	jack? ( media-sound/jack-audio-connection-kit )
	>=media-libs/ladspa-sdk-1.0
	>=media-libs/ladspa-cmt-1.14"

src_compile() {
	addwrite ${QTDIR}/etc/settings
	econf `use_with jack` \
		--with-ladspa \
		|| die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README TODO TRANSLATORS
}
