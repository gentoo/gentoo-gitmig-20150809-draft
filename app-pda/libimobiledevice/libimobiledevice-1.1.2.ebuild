# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.1.2.ebuild,v 1.3 2012/04/03 04:56:34 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="python? 2:2.7"

inherit python

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="imobiledevice_backend_gnutls +imobiledevice_backend_openssl python static-libs"

RDEPEND=">=app-pda/libplist-1.8-r1[python?]
	>=app-pda/usbmuxd-0.1.4
	imobiledevice_backend_openssl? ( dev-libs/openssl:0 )
	imobiledevice_backend_gnutls? (
		dev-libs/libgcrypt
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
		)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-python/cython-0.13 )"

REQUIRED_USE="^^ ( imobiledevice_backend_openssl imobiledevice_backend_gnutls )"

DOCS=( AUTHORS NEWS README )

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
	local myconf
	use python || myconf+=' --without-cython'
	use imobiledevice_backend_openssl || myconf+=' --disable-openssl'

	econf \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	default

	dohtml docs/html/*

	find "${ED}" -name '*.la' -exec rm -f {} +
}
