# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/di/di-4.27.ebuild,v 1.1 2011/06/15 05:02:23 jer Exp $

inherit toolchain-funcs

DESCRIPTION="Disk Information Utility"
HOMEPAGE="http://www.gentoo.com/di/"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

src_compile() {
	emake prefix=/usr CC="$(tc-getCC)" || die
}

src_install() {
	emake install prefix="${D}/usr" || die
	# default symlink is broken
	dosym di /usr/bin/mi
	dodoc README
}
