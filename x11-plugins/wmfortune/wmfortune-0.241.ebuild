# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfortune/wmfortune-0.241.ebuild,v 1.1 2003/06/26 12:46:33 vapier Exp $

DESCRIPTION="dock-app that shows forune messages"
HOMEPAGE="http://www.01.246.ne.jp/~m-sugano/apps.html"
SRC_URI="http://www.01.246.ne.jp/~m-sugano/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"

DEPEND="app-games/fortune-mod
	virtual/x11"
RDEPEND=""

src_compile() {
	emake OPTIMIZE="${CFLAGS}" || die
}

src_install() {
	dobin wmfortune
	dodoc CHANGES README TODO
}
