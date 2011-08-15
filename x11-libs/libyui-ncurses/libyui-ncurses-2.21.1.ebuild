# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libyui-ncurses/libyui-ncurses-2.21.1.ebuild,v 1.1 2011/08/15 09:30:11 miska Exp $

EAPI=4

inherit autotools

DESCRIPTION="UI abstraction library - GTK plugin"
HOMEPAGE="http://sourceforge.net/projects/libyui/"
SRC_URI="mirror://sourceforge/libyui/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses
	x11-libs/libyui
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
	rm -rf "${ED}/usr/include"
}
