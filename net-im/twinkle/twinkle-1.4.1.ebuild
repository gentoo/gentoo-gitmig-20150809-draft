# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twinkle/twinkle-1.4.1.ebuild,v 1.3 2009/04/15 21:29:48 maekke Exp $

EAPI=2
ARTS_REQUIRED="never"
inherit eutils qt3 kde autotools

DESCRIPTION="a soft phone for your VOIP communcations using SIP"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="kde arts speex ilbc zrtp kdehiddenvisibility"

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
RDEPEND=">=net-libs/ccrtp-1.6.0
	>=dev-cpp/commoncpp2-1.6.1
	x11-libs/qt:3
	media-libs/libsndfile
	dev-libs/boost
	speex? ( media-libs/speex )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	zrtp? ( >=net-libs/libzrtpcpp-1.3.0 )
	media-libs/alsa-lib"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use speex && has_version '~media-libs/speex-1.2_beta2' &&
		! built_with_use 'media-libs/speex' 'wideband' ; then
		eerror "You need to build media-libs/speex with USE=wideband enabled."
		die "Speex w/o wideband-support detected."
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-kdedetect.patch
	eautoreconf
}

src_configure() {
	local myconf=" \
			$(use_with kde) \
			$(use_with ilbc) \
			$(use_with arts) \
			$(use_with zrtp) \
			$(use_with speex)"
	set-kdedir
	kde_src_compile configure
}

src_compile() {
	kde_src_compile make
}

src_install() {
	kde_src_install
	domenu twinkle.desktop
	dodoc THANKS
}
