# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freqtweak/freqtweak-0.6.0.ebuild,v 1.4 2004/11/23 04:45:50 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="tool for FFT-based realtime audio spectral manipulation and display"
HOMEPAGE="http://freqtweak.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

DEPEND="x11-libs/wxGTK
	>=dev-libs/fftw-3.0
	>=dev-libs/libsigc++-0.14
	dev-libs/libxml2
	media-sound/jack-audio-connection-kit"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

pkg_setup() {
	if wx-config --cppflags | grep gtk2u >& /dev/null; then
		einfo "${PN} will not build if wxGTK was compiled"
		einfo "with unicode support.  If you are using a version of"
		einfo "wxGTK <= 2.4.2, you must set USE=-gtk2.  In newer versions,"
		einfo "you must set USE=-unicode."
		die "wxGTK must be re-emerged without unicode suport"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
