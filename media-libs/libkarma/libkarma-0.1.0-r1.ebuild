# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkarma/libkarma-0.1.0-r1.ebuild,v 1.2 2009/05/14 20:21:49 maekke Exp $

EAPI=2
inherit eutils mono toolchain-funcs

DESCRIPTION="Support library for using Rio devices with mtp"
HOMEPAGE="http://www.freakysoft.de/html/libkarma/"
SRC_URI="http://www.freakysoft.de/html/libkarma/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/libiconv
	media-libs/taglib
	dev-lang/mono
	dev-libs/libusb"
DEPEND="${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch
}

src_compile() {
	tc-export AR CC RANLIB
	emake all || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc THANKS TODO
	mono_multilib_comply
}
