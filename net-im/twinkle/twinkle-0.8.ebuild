# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twinkle/twinkle-0.8.ebuild,v 1.1 2006/07/06 05:24:37 dragonheart Exp $

inherit eutils qt3  autotools

DESCRIPTION="a soft phone for your VOIP communcations using SIP"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts speex"

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
RDEPEND=">=net-libs/ccrtp-1.3.4
	>=x11-libs/qt-3.3.4-r6
	>=dev-cpp/commoncpp2-1.4.1
	arts? ( kde-base/arts )
	media-libs/libsndfile
	media-libs/speex
	dev-libs/boost
	speex? ( media-libs/speex )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${PN}-0.4.1-badcflags.patch
	epatch "${FILESDIR}"/${P}-autoconfspeex.patch
	eautoreconf
}

src_compile() {
	econf --with-ilbc $(use_with arts) $(use_with speex) || die 'Error: conf failed'
	emake || die "Error: emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README THANKS
}
