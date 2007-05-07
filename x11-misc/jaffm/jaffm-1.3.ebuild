# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/jaffm/jaffm-1.3.ebuild,v 1.2 2007/05/07 01:00:14 dirtyepic Exp $

inherit toolchain-funcs wxwidgets

DESCRIPTION="Very lightweight file manager"
HOMEPAGE="http://jaffm.binary.is/"

SRC_URI="http://www.binary.is/download/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	WX_GTK_VER="2.6"
	need-wxwidgets gtk2
	sed -i \
		-e "/^CPP=/ s:g++:$(tc-getCXX):" \
		-e "/^PREFIX=/ s:/local::" \
		-e "s:wx-config:${WX_CONFIG}:g" \
		-e "/^FLAGS=/ s:^.*$:FLAGS=${CXXFLAGS}:" \
		Makefile
}

src_install() {
	dobin jaffm
	dodoc README
}
