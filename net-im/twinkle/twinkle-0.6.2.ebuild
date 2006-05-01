# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twinkle/twinkle-0.6.2.ebuild,v 1.2 2006/05/01 18:01:53 dertobi123 Exp $

inherit eutils qt3

DESCRIPTION="a soft phone for your VOIP communcations using SIP"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts"

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
RDEPEND=">=net-libs/ccrtp-1.3.4
	>=x11-libs/qt-3.3.4-r6
	>=dev-cpp/commoncpp2-1.3.0
	arts? ( kde-base/arts )
	media-libs/libsndfile"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.4.1-badcflags.patch
}

src_compile() {
	econf $(use_with arts) || die 'Error: conf failed'
	emake -j1 || die "Error: emake failed!"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README THANKS
}
