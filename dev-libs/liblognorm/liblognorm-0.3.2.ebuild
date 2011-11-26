# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblognorm/liblognorm-0.3.2.ebuild,v 1.1 2011/11/26 19:37:34 maksbotan Exp $

EAPI=4

AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools-utils

DESCRIPTION="Fast samples-based log normalization library"
HOMEPAGE="http://www.liblognorm.com"
SRC_URI="http://www.liblognorm.com/files/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86"
IUSE="debug static-libs"

DEPEND="
	dev-libs/libestr
	dev-libs/libee"
RDEPEND="${DEPEND}"

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)

	autotools-utils_src_configure
}

src_compile() {
	emake -j1
}
