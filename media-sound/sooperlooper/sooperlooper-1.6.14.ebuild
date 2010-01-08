# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sooperlooper/sooperlooper-1.6.14.ebuild,v 1.2 2010/01/08 17:08:09 mr_bones_ Exp $

EAPI=2
inherit autotools eutils wxwidgets

DESCRIPTION="Live looping sampler with immediate loop recording"
HOMEPAGE="http://essej.net/sooperlooper/index.html"
SRC_URI="http://essej.net/sooperlooper/${P/_p/-}.tar.gz
	mirror://gentoo/${PN}-1.6.5-m4.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-sound/jack-audio-connection-kit
	x11-libs/wxGTK:2.8
	media-libs/liblo
	dev-libs/libsigc++:1.2
	media-libs/libsndfile
	media-libs/libsamplerate
	dev-libs/libxml2
	media-libs/rubberband
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_p*}

src_prepare() {
	cp -rf "${WORKDIR}"/aclocal "${S}" || die "copying aclocal failed"

	epatch "${FILESDIR}"/${PN}-1.6.5-cxxflags.patch \
		"${FILESDIR}"/${PN}-1.6.10-asneeded.patch
		#"${FILESDIR}"/${P}-const.patch

	AT_M4DIR="${S}/aclocal" eautoreconf
}

src_configure() {
	WX_GTK_VER="2.8"
	need-wxwidgets unicode

	econf \
		--disable-dependency-tracking \
		--disable-optimize \
		--with-wxconfig-path="${WX_CONFIG}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc OSC README
}
