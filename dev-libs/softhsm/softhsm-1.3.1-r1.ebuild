# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/softhsm/softhsm-1.3.1-r1.ebuild,v 1.1 2012/01/25 22:34:15 mschiff Exp $

EAPI=4

DESCRIPTION="A software PKCS#11 implementation"
HOMEPAGE="http://www.opendnssec.org/"
SRC_URI="http://www.opendnssec.org/files/source/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="debug"
SLOT="0"
LICENSE="BSD"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/botan-1.10.1[threads]
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS NEWS README )

src_configure() {
	econf \
		--disable-static \
		--with-botan="${EPREFIX}/usr/" \
		$(use_enable amd64 64bit) \
		$(use debug && echo "--with-loglevel=4")
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	ewarn "Please note: The system path of this library has changed."
	ewarn ""
	ewarn "Applications using the full path to libsofthsm.so in their"
	ewarn "configuration need to be updated."
	ewarn ""
	ewarn "Old path: /usr/lib/libsofthsm.so"
	ewarn "New path: /usr/lib/softhsm/libsofthsm.so"
	ewarn ""
	ewarn "Please update your configuration accordingly."
	ewarn ""
	ewarn "net-dns/opendnssec users: That means you"
}
