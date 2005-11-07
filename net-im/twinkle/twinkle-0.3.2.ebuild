# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twinkle/twinkle-0.3.2.ebuild,v 1.1 2005/11/07 10:54:11 dragonheart Exp $

inherit eutils qt3

DESCRIPTION="Twinkle is a soft phone for your VOIP communcations using SIP."
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
RDEPEND=">=net-libs/ccrtp-1.3.4
	>=x11-libs/qt-3.3.4-r6
	>=dev-cpp/commoncpp2-1.3.0"

DEPEND="${REDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-badcflags.patch
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README THANKS
}
