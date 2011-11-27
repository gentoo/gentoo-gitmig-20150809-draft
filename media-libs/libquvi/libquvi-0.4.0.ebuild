# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquvi/libquvi-0.4.0.ebuild,v 1.3 2011/11/27 04:08:04 radhermit Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Library for parsing video download links"
HOMEPAGE="http://quvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/quvi/${PV:0:3}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples static-libs"

RDEPEND=">=net-misc/curl-7.18.2
	!<media-libs/quvi-0.4.0
	>=media-libs/libquvi-scripts-0.4.0
	>=dev-lang/lua-5.1[deprecated]"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	econf \
		--with-manual \
		$(use_enable static-libs static)
}

src_install() {
	default

	if use examples ; then
		docinto examples
		dodoc examples/*.{c,h}
	fi

	remove_libtool_files all
}
