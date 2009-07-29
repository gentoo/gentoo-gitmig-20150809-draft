# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtrain/libtrain-0.9b.ebuild,v 1.12 2009/07/29 22:17:03 vostorga Exp $

inherit toolchain-funcs

DESCRIPTION="Library for calculating fastest train routes"
SRC_URI="http://www.on.rim.or.jp/~katamuki/software/train/${P}.tar.gz"
HOMEPAGE="http://www.on.rim.or.jp/~katamuki/software/train/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die
	emake CC="$(tc-getCC)" || die
}

src_install () {
	make DESTDIR="${D}" install || die
}
