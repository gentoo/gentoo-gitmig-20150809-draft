# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.2.ebuild,v 1.2 2009/05/14 08:35:13 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Teletext viewer for X11"
HOMEPAGE="http://www.goron.de/~froese/"
SRC_URI="http://www.goron.de/~froese/alevt/${P}.tar.gz"
RESTRICT="strip"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="x11-libs/libX11
	>=media-libs/libpng-1.0.12"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	cp -va Makefile{,.orig}
	epatch "${FILESDIR}"/${P}-respectflags.patch
}

src_compile() {
	append-flags -fno-strict-aliasing
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin alevt alevt-cap alevt-date
	doman alevt.1x alevt-date.1 alevt-cap.1
	dodoc CHANGELOG README

	insinto /usr/share/icons/hicolor/16x16/apps
	newins contrib/mini-alevt.xpm alevt.xpm
	insinto /usr/share/icons/hicolor/48x48/apps
	newins contrib/icon48x48.xpm alevt.xpm

	make_desktop_entry alevt "AleVT" alevt
}
