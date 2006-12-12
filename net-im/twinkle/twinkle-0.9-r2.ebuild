# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twinkle/twinkle-0.9-r2.ebuild,v 1.1 2006/12/12 11:14:36 dragonheart Exp $

inherit eutils qt3

DESCRIPTION="a soft phone for your VOIP communcations using SIP"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts speex ilbc zrtp"

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
RDEPEND=">=net-libs/ccrtp-1.5.0
	>=dev-cpp/commoncpp2-1.4.1
	$(qt_min_version 3.3.0)
	arts? ( kde-base/arts )
	media-libs/libsndfile
	dev-libs/boost
	speex? ( media-libs/speex )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	zrtp? ( net-libs/libzrtpcpp )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.4.1-badcflags.patch
	epatch "${FILESDIR}"/${P}-dtmf.patch
	epatch "${FILESDIR}"/${P}-invite4xx.patch
	epatch "${FILESDIR}"/${P}-memman.patch
}

src_compile() {
	econf \
			$(use_with ilbc) \
			$(use_with arts) \
			$(use_with zrtp) \
			$(use_with speex) || die 'Error: conf failed'
	emake || die "Error: emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README THANKS
	domenu twinkle.desktop
}

pkg_postinst() {
	einfo "if you get crashes on startup re-emerge commoncpp2 ccrtp and	twinkle"
	einfo "see http://www.xs4all.nl/~mfnboer/twinkle/faq.html#crash_startup"
}
