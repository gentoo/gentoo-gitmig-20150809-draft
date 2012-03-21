# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ytree/ytree-1.97.ebuild,v 1.2 2012/03/21 15:22:43 tomka Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="A (curses-based) file manager"
HOMEPAGE="http://www.han.de/~werner/ytree.html"
SRC_URI="http://www.han.de/~werner/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/readline
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.94-bindir.patch
}

pkg_setup() {
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}usr" install || die "emake install failed"
	dodoc ytree.conf
}
