# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twinkle/twinkle-1.2.ebuild,v 1.2 2008/05/01 13:17:29 dragonheart Exp $

ARTS_REQUIRED="never"
inherit eutils qt3 kde

DESCRIPTION="a soft phone for your VOIP communcations using SIP"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="arts speex ilbc zrtp kdehiddenvisibility"

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
RDEPEND=">=net-libs/ccrtp-1.5.0
	>=dev-cpp/commoncpp2-1.4.2
	$(qt_min_version 3.3.0)
	media-libs/libsndfile
	dev-libs/boost
	speex? ( media-libs/speex )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	zrtp? ( ~net-libs/libzrtpcpp-0.9.0 )
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

src_compile() {
	local myconf=" \
			$(use_with ilbc) \
			$(use_with arts) \
			$(use_with zrtp) \
			$(use_with speex)"
	set-kdedir
	kde_src_compile
}

src_install() {
	kde_src_install
	dodoc THANKS
	domenu twinkle.desktop
}

pkg_postinst() {
	elog "if you get crashes on startup re-emerge commoncpp2 ccrtp and	twinkle"
	elog "see http://www.xs4all.nl/~mfnboer/twinkle/faq.html#crash_startup"
	kde_pkg_postinst
}
