# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/wxchtdecoder/wxchtdecoder-1.5.ebuild,v 1.6 2009/08/18 00:44:02 mr_bones_ Exp $

EAPI=2
WX_GTK_VER="2.6"
inherit wxwidgets

DESCRIPTION="A program to decode .CHT files in Snes9x and ZSNES to plain text"
HOMEPAGE="http://games.technoplaza.net/chtdecoder/"
SRC_URI="http://games.technoplaza.net/chtdecoder/wx/history/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.6[X]"

src_configure() {
	econf --with-wx-config=${WX_CONFIG}
}

src_install() {
	dobin src/wxchtdecoder || die "dobin failed"
	dodoc doc/wxchtdecoder.txt
}
