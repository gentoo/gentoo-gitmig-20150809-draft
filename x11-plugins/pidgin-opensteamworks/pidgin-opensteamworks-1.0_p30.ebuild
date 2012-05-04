# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-opensteamworks/pidgin-opensteamworks-1.0_p30.ebuild,v 1.1 2012/05/04 15:53:52 hasufell Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Steam protocol plugin for pidgin"
HOMEPAGE="http://code.google.com/p/pidgin-opensteamworks/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	net-im/pidgin"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	# see http://code.google.com/p/pidgin-opensteamworks/issues/detail?id=31
	cp "${FILESDIR}"/${P}-Makefile "${S}"/Makefile || die
}
