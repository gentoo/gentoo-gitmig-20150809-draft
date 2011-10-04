# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.1.1.ebuild,v 1.4 2011/10/04 13:41:24 nativemad Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6"

inherit python

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE="python static-libs"

RDEPEND=">=app-pda/libplist-0.15
	>=app-pda/usbmuxd-0.1.4
	>=dev-libs/glib-2.28.6
	dev-libs/libgcrypt
	>=dev-libs/libtasn1-1.1
	>=net-libs/gnutls-1.6.3
	sys-fs/fuse
	virtual/libusb:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-lang/swig-2.0.0 )"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	sed -i -e 's:1.3.21:2.0.0:g' configure || die

	rm -f py-compile
	ln -s $(type -P true) py-compile
}

src_configure() {
	# --with-swig is same as --without-swig wrt #361029

	local myconf
	use python || myconf="--without-swig"

	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS NEWS README
	dohtml docs/html/*

	find "${D}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	use python && python_mod_optimize imobiledevice
}

pkg_postrm() {
	use python && python_mod_cleanup imobiledevice
}
