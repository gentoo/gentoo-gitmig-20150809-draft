# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libyubikey/libyubikey-1.6.ebuild,v 1.2 2012/06/24 10:07:41 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Yubico C low-level library"
HOMEPAGE="http://code.google.com/p/yubico-c/"
SRC_URI="http://yubico-c.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE="static-libs"

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
	dodoc AUTHORS ChangeLog NEWS README THANKS
	prune_libtool_files
}
