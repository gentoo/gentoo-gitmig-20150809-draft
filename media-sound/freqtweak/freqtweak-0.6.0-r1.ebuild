# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freqtweak/freqtweak-0.6.0-r1.ebuild,v 1.1 2005/04/25 16:50:52 luckyduck Exp $

inherit eutils wxwidgets

DESCRIPTION="FFT-based realtime audio spectral manipulation and display"
HOMEPAGE="http://freqtweak.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.4*
	>=sci-libs/fftw-3.0
	=dev-libs/libsigc++-1.2*
	dev-libs/libxml2
	media-sound/jack-audio-connection-kit"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	if use gtk2; then
		need-wxwidgets gtk2 || die "No gtk2 version of x11-libs/wxGTK found"
	else
		need-wxwidgets gtk || die "No gtk1 version of x11-libs/wxGTK found"
	fi
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
