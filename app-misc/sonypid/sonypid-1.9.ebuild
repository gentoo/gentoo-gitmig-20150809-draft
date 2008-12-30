# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-1.9.ebuild,v 1.10 2008/12/30 20:27:16 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://www.popies.net/sonypi/"
SRC_URI="http://www.popies.net/sonypi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="x11-libs/libXtst
	x11-proto/inputproto"

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin sonypid || die "dobin failed"
	dodoc AUTHORS CHANGES
}
