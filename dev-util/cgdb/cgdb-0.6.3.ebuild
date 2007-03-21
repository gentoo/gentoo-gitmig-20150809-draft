# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cgdb/cgdb-0.6.3.ebuild,v 1.2 2007/03/21 03:00:47 nerdboy Exp $

inherit eutils autotools

DESCRIPTION="A curses front-end for GDB, the GNU debugger"
HOMEPAGE="http://cgdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/cgdb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.3-r1
	>=sys-libs/readline-5.1-r2"

RDEPEND="${DEPEND}
	>=sys-devel/gdb-5.3"

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-fbsd.patch"
	epatch "${FILESDIR}/${P}-makefile-race.patch"

	AT_M4DIR="${S}/config" eautomake
}

src_compile() {
	econf || die "econf failed"

	# not very parallel-friendly makefiles have been patched
	# (see bug 171502)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
}
