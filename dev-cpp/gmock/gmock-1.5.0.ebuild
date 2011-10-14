# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gmock/gmock-1.5.0.ebuild,v 1.1 2011/10/14 19:26:57 vapier Exp $

EAPI="4"

DESCRIPTION="Google's C++ mocking framework"
HOMEPAGE="http://code.google.com/p/googlemock/"
SRC_URI="http://googlemock.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="static-libs"

RDEPEND=">=dev-util/gtest-${PV}"
DEPEND="${RDEPEND}"

src_unpack() {
	default
	# make sure we always use the system one
	rm -r "${S}"/gtest/Makefile* || die
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || find "${D}" -name '*.la' -delete
}
