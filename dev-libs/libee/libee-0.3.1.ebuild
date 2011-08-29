# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libee/libee-0.3.1.ebuild,v 1.1 2011/08/29 19:48:16 maksbotan Exp $

EAPI=4

AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="An Event Expression Library inspired by CEE"
HOMEPAGE="http://www.libee.org"
SRC_URI="http://www.libee.org/files/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86"
IUSE="debug static-libs"

DEPEND="dev-libs/libxml2
	dev-libs/libestr"
RDEPEND="${DEPEND}"

DOCS=(INSTALL ChangeLog)

src_configure() {
	local myeconfargs=(
		--enable-testbench
	)
	autotools-utils_src_configure
}

src_compile() {
	emake -j1
}
