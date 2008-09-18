# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cgdb/cgdb-0.6.4.ebuild,v 1.1 2008/09/18 07:32:21 vapier Exp $

inherit eutils

DESCRIPTION="A curses front-end for GDB, the GNU debugger"
HOMEPAGE="http://cgdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/cgdb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.3-r1
	>=sys-libs/readline-5.1-r2"
RDEPEND="${DEPEND}
	>=sys-devel/gdb-5.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-64bit.patch
	epatch "${FILESDIR}"/${P}-headers.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
