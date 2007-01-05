# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freqtweak/freqtweak-0.6.0.ebuild,v 1.8 2007/01/05 17:31:41 flameeyes Exp $

IUSE=""

inherit eutils

DESCRIPTION="tool for FFT-based realtime audio spectral manipulation and display"
HOMEPAGE="http://freqtweak.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="x11-libs/wxGTK
	>=sci-libs/fftw-3.0
	=dev-libs/libsigc++-1.2*
	dev-libs/libxml2
	media-sound/jack-audio-connection-kit"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

pkg_setup() {
	if wx-config --cppflags | grep gtk2u >& /dev/null; then
		eerror "${PN} will not build if wxGTK was compiled"
		eerror "with unicode support.  If you are using a version of"
		eerror "wxGTK <= 2.4.2, you must set USE=-gtk2.	 In newer versions,"
		eerror "you must set USE=-unicode."
		die "wxGTK must be re-emerged without unicode suport"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
