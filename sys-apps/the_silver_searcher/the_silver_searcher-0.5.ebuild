# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/the_silver_searcher/the_silver_searcher-0.5.ebuild,v 1.2 2012/04/27 17:40:08 jdhore Exp $

EAPI=4
inherit autotools

DESCRIPTION="A code-searching tool similar to ack, but faster"
HOMEPAGE="http://github.com/ggreer/the_silver_searcher"
SRC_URI="mirror://github/ggreer/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libpcre"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

DOCS="README.md"

src_prepare() {
	eautoreconf
}
