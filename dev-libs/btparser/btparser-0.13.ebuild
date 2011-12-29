# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/btparser/btparser-0.13.ebuild,v 1.2 2011/12/29 17:23:37 pacho Exp $

EAPI="4"

DESCRIPTION="Parser and analyzer for backtraces produced by gdb"
HOMEPAGE="https://fedorahosted.org/btparser/"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="static-libs"

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-maintainer-mode
}

src_install() {
	default
	use static-libs || find "${D}" -name '*.la' -exec rm -f {} +
}
