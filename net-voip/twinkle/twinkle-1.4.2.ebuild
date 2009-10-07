# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/twinkle/twinkle-1.4.2.ebuild,v 1.2 2009/10/07 21:51:38 maekke Exp $

EAPI=2
ARTS_REQUIRED="never"
inherit eutils qt3 kde autotools

DESCRIPTION="a soft phone for your VOIP communcations using SIP"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="kde arts speex ilbc zrtp"

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
# Now speex so we don't need built_with_use checks for wideband any more
RDEPEND=">=net-libs/ccrtp-1.6.0
	>=dev-cpp/commoncpp2-1.6.1
	x11-libs/qt:3
	media-libs/libsndfile
	dev-libs/boost
	speex? ( >=media-libs/speex-1.2_beta3 )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	zrtp? ( >=net-libs/libzrtpcpp-1.3.0 )
	media-libs/alsa-lib"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4.1-kdedetect.patch
	eautoreconf
}

src_configure() {
	local myconf=" \
			$(use_with kde) \
			$(use_with ilbc) \
			$(use_with arts) \
			$(use_with zrtp) \
			$(use_with speex)"
	kde_src_configure myconf configure
}

src_compile() {
	kde_src_compile make
}

src_install() {
	kde_src_install
	domenu twinkle.desktop
	dodoc THANKS
}
