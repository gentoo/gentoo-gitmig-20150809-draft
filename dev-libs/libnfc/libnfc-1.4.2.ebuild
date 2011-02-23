# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnfc/libnfc-1.4.2.ebuild,v 1.1 2011/02/23 12:08:14 ikelos Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Near Field Communications (NFC) library"
HOMEPAGE="http://www.libnfc.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND="sys-apps/pcsc-lite
		 dev-libs/libusb"
DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )"

src_compile() {
	emake || die "Failed to compile."
	use doc && doxygen
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install properly."
	use doc && dohtml "${S}"/doc/html/*
}
