# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblastfm/liblastfm-0.3.0.ebuild,v 1.11 2010/07/07 20:32:57 ssuominen Exp $

EAPI="2"

inherit multilib

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="http://github.com/mxcl/liblastfm/"
SRC_URI="http://cdn.last.fm/src/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
SLOT="0"
IUSE=""

COMMON_DEPEND="
	>=media-libs/libsamplerate-0.1.4
	sci-libs/fftw:3.0
	>=x11-libs/qt-core-4.5:4
	>=x11-libs/qt-sql-4.5:4
"
DEPEND="${COMMON_DEPEND}
	dev-lang/ruby
	>=x11-libs/qt-test-4.5:4
"
RDEPEND="${COMMON_DEPEND}
	!<media-libs/lastfmlib-0.4.0
"

src_prepare() {
	# Fix multilib paths
	find . -name *.pro -exec sed -i -e "/target.path/s/lib/$(get_libdir)/g" {} + \
		|| die "failed to fix multilib paths"

	# >=1.9 ruby compatibility
	case `ruby -e 'puts RUBY_VERSION'` in
		1.8.*) ;;
		*) sed -e "s/require 'ftools'//g" -i admin/* || die ;;
	esac
}

src_configure() {
	./configure --prefix "${ROOT}usr" --no-strip --release || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}${ROOT}" install || die "emake install failed"

	dodoc README || die "dodoc failed"
}
