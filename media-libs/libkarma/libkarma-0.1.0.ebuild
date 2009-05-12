# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkarma/libkarma-0.1.0.ebuild,v 1.7 2009/05/12 09:55:02 ssuominen Exp $

EAPI=2
inherit eutils mono multilib

DESCRIPTION="Support library for using Rio devices with mtp"
HOMEPAGE="http://www.freakysoft.de/html/libkarma/"
SRC_URI="http://www.freakysoft.de/html/libkarma/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="mono"

RDEPEND="virtual/libiconv
	media-libs/taglib
	mono? ( dev-lang/mono )
	dev-libs/libusb"
DEPEND="${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	use mono || epatch "${FILESDIR}"/libkarma-0.0.6-mono.patch
	epatch "${FILESDIR}"/${P}-multilib.patch
}

src_compile() {
	emake all || die "emake failed"
}

src_install() {
	export _LIBDIR=$(get_libdir)
	emake PREFIX="${D}/usr" install || die "emake install failed"
}
