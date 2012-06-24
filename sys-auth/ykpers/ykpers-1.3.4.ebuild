# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/ykpers/ykpers-1.3.4.ebuild,v 1.5 2012/06/24 10:17:35 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey"
HOMEPAGE="http://code.google.com/p/yubikey-personalization"
SRC_URI="http://yubikey-personalization.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE="static-libs"

RDEPEND=">=sys-auth/libyubikey-1.6
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-rpath.patch
	sed -i -e '/AM_INIT_AUTOMAKE/s: -Werror::' configure.ac || die #423255
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README doc/*
	prune_libtool_files
}
