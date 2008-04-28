# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/wxchtdecoder/wxchtdecoder-1.5.ebuild,v 1.5 2008/04/28 21:51:30 drac Exp $

inherit wxwidgets

DESCRIPTION="A program to decode .CHT files in Snes9x and ZSNES to plain text"
HOMEPAGE="http://games.technoplaza.net/chtdecoder/"
SRC_URI="http://games.technoplaza.net/chtdecoder/wx/history/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*"

pkg_setup() {
	WX_GTK_VER=2.6 need-wxwidgets gtk2
}

src_compile() {
	econf --with-wx-config=${WX_CONFIG} || die
	emake || die "emake failed"
}

src_install() {
	dobin src/wxchtdecoder || die "dobin failed"
	dodoc doc/wxchtdecoder.txt
}
