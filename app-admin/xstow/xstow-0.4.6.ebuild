# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/xstow/xstow-0.4.6.ebuild,v 1.7 2004/06/25 23:07:13 vapier Exp $

inherit eutils

DESCRIPTION="replacement for GNU stow with extensions"
HOMEPAGE="http://xstow.sourceforge.net/"
SRC_URI="mirror://sourceforge/xstow/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ncurses"

DEPEND="virtual/libc
	ncurses? ( sys-libs/ncurses )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-configure-ncurses.diff
}

src_compile() {
	econf `use_with ncurses` || die
	emake || die
}

src_install() {
	dodoc README AUTHORS NEWS README TODO ChangeLog
	make DESTDIR=${D} PACKAGE=${P} install || die
}
