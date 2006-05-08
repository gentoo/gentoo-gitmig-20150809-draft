# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hexcurse/hexcurse-1.55.ebuild,v 1.12 2006/05/08 04:50:20 tcort Exp $

inherit eutils

DESCRIPTION="ncurses based hex editor"
HOMEPAGE="http://www.jewfish.net/description.php?title=HexCurse"
SRC_URI="http://www.jewfish.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc-macos sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc.patch
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
