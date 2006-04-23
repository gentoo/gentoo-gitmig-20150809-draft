# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/wxchtdecoder/wxchtdecoder-1.5.ebuild,v 1.1 2006/04/23 07:56:49 mr_bones_ Exp $

DESCRIPTION="A program to decode .CHT files in Snes9x and ZNSES to plain text"
HOMEPAGE="http://games.technoplaza.net/chtdecoder/"
SRC_URI="http://games.technoplaza.net/chtdecoder/wx/history/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-libs/wxGTK-2.4.2"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.3.1"

src_install() {
	dobin src/wxchtdecoder || die "dobin failed"
	dodoc doc/wxchtdecoder.txt
}
