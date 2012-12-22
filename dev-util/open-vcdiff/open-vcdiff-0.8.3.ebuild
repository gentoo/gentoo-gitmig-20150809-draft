# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/open-vcdiff/open-vcdiff-0.8.3.ebuild,v 1.1 2012/12/22 18:28:38 floppym Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="An encoder/decoder for the VCDIFF (RFC3284) format"
HOMEPAGE="http://code.google.com/p/open-vcdiff/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/0"
KEYWORDS="~amd64"
IUSE=""

src_configure() {
	local myeconfargs=(
		--enable-shared
		--disable-static
	)
	autotools-utils_src_configure
}
