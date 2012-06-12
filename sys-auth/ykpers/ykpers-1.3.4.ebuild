# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/ykpers/ykpers-1.3.4.ebuild,v 1.4 2012/06/12 11:52:06 iksaif Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey"
SRC_URI="http://yubikey-personalization.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://code.google.com/p/yubikey-personalization"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE=""

RDEPEND=">=sys-auth/libyubikey-1.6
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-rpath.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README doc/* || die
	find "${D}" -name '*.la' -delete || die
}
