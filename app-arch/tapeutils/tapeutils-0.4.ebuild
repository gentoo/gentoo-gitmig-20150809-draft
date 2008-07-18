# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tapeutils/tapeutils-0.4.ebuild,v 1.2 2008/07/18 23:04:52 cla Exp $

inherit toolchain-funcs

DESCRIPTION="Utilities for manipulation of tapes and tape image files"
HOMEPAGE="http://www.brouhaha.com/~eric/software/tapeutils/"
SRC_URI="http://www.brouhaha.com/~eric/software/tapeutils/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin tapecopy tapedump
	# no docs to install
}
