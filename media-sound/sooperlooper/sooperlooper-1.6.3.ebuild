# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sooperlooper/sooperlooper-1.6.3.ebuild,v 1.2 2008/05/15 12:35:14 corsair Exp $

EAPI=1

inherit wxwidgets

DESCRIPTION="Live looping sampler with immediate loop recording"
HOMEPAGE="http://essej.net/sooperlooper/index.html"
SRC_URI="http://essej.net/sooperlooper/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-sound/jack-audio-connection-kit
	x11-libs/wxGTK:2.6
	media-libs/liblo
	dev-libs/libsigc++:1.2
	media-libs/libsndfile
	media-libs/libsamplerate
	dev-libs/libxml2
	media-libs/rubberband
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	WX_GTK_VER="2.6"
	need-wxwidgets gtk2
	econf --disable-optimize --with-wxconfig-path="${WX_CONFIG}"
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc OSC README
}
