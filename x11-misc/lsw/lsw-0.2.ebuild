# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lsw/lsw-0.2.ebuild,v 1.1 2011/06/20 18:39:27 jer Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="list window names"
HOMEPAGE="http://tools.suckless.org/lsw"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	sed -i Makefile \
		-e "s/.*strip.*//" || die

	sed -i config.mk \
		-e '/^CC/d' \
		-e 's/CFLAGS = -Os/CFLAGS +=/' \
		-e '/^LDFLAGS/{s| = | += |;s| -s | |}' || die
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dodir /usr/share/man/man1
	emake DESTDIR="${D}" PREFIX="/usr"
}
