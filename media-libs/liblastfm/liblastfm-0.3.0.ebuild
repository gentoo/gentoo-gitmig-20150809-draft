# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblastfm/liblastfm-0.3.0.ebuild,v 1.4 2009/11/09 11:24:10 ssuominen Exp $

EAPI="2"

inherit multilib

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="http://github.com/mxcl/liblastfm/"
SRC_URI="http://cdn.last.fm/src/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	>=media-libs/libsamplerate-0.1.4
	sci-libs/fftw:3.0
	>=x11-libs/qt-core-4.5:4
	!media-libs/lastfmlib
"
# Unrestrict Ruby depend for next release!
DEPEND="${COMMON_DEPEND}
	=dev-lang/ruby-1.8*
"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	# Fix multilib paths
	find . -name *.pro -exec sed -i -e "/target.path/s/lib/$(get_libdir)/g" {} + \
		|| die "failed to fix multilib paths"
}

src_configure() {
	./configure --prefix "${ROOT}usr" --no-strip --release || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}${ROOT}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
}
