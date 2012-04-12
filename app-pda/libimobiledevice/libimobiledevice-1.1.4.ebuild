# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.1.4.ebuild,v 1.1 2012/04/12 14:41:27 ssuominen Exp $

EAPI=4
PYTHON_DEPEND="python? 2:2.7"
inherit python

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="gnutls python"

RDEPEND=">=app-pda/libplist-1.8-r1[python?]
	>=app-pda/usbmuxd-1.0.8
	gnutls? (
		dev-libs/libgcrypt
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
		)
	!gnutls? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-python/cython-0.13 )"

DOCS="AUTHORS NEWS README"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	>py-compile
}

src_configure() {
	local myconf='--disable-static'
	use python || myconf+=' --without-cython'
	use gnutls && myconf+=' --disable-openssl'
	econf ${myconf}
}

src_install() {
	default
	dohtml docs/html/*
	find "${ED}" -name '*.la' -exec rm -f {} +
}
