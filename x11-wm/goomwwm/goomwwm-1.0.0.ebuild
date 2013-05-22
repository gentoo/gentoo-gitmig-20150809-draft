# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/goomwwm/goomwwm-1.0.0.ebuild,v 1.1 2013/05/22 21:59:24 jer Exp $

EAPI=5
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Get out of my way, Window Manager!"
HOMEPAGE="http://aerosuidae.net/goomwwm/"
SRC_URI="http://aerosuidae.net/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	x11-libs/libXft
	x11-libs/libX11
	x11-libs/libXinerama
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-proto/xineramaproto
	x11-proto/xproto
"

src_configure() {
	use debug && append-cflags -DDEBUG
	append-cflags -include proto.h
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		proto normal
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
