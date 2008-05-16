# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkarma/libkarma-0.1.0.ebuild,v 1.3 2008/05/16 18:37:29 nixnut Exp $

inherit eutils mono

DESCRIPTION="Support library for using Rio devices with mtp"
HOMEPAGE="http://www.freakysoft.de/html/libkarma/"
SRC_URI="http://www.freakysoft.de/html/libkarma/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~x86"
IUSE="mono"

DEPEND="virtual/libiconv
	media-libs/taglib
	mono? ( dev-lang/mono )
	dev-libs/libusb"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use !mono && epatch "${FILESDIR}/libkarma-0.0.6-mono.patch"
}

src_compile() {
	emake -j1 all || die "emake failed"
}

src_install() {
	emake -j1 PREFIX="${D}/usr" install || die "emake install failed"
}
