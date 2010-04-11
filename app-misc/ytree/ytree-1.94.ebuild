# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ytree/ytree-1.94.ebuild,v 1.1 2010/04/11 15:48:22 jokey Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="A (curses-based) file manager"
HOMEPAGE="http://www.han.de/~werner/ytree.html"
SRC_URI="http://www.han.de/~werner/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/readline
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-bindir.patch
}

pkg_setup() {
	tc-export CC
}

src_install() {
	emake DESTDIR=${D}usr install || die "emake install failed"
	dodoc ytree.conf
}
