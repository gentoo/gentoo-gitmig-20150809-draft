# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.1-r1.ebuild,v 1.6 2007/11/27 11:58:57 zzam Exp $

inherit eutils

DESCRIPTION="Teletext viewer for X11"
HOMEPAGE="http://www.goron.de/~froese/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/video/${P}.tar.gz
	 http://fresh.t-systems-sfr.com/linux/src/${P}.tar.gz
	 http://www.baycom.org/~tom/${PN}-dvb.patch"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"

RDEPEND="x11-libs/libX11
	>=media-libs/libpng-1.0.12"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:^OPT=.*:OPT = ${CFLAGS} -s:" Makefile
	epatch "${FILESDIR}"/${P}-gentoo.diff
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${DISTDIR}"/${PN}-dvb.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin alevt alevt-cap alevt-date
	doman alevt.1x alevt-date.1 alevt-cap.1
	dodoc CHANGELOG COPYRIGHT README

	insinto /usr/share/icons/hicolor/16x16/apps
	newins contrib/mini-alevt.xpm alevt.xpm
	insinto /usr/share/icons/hicolor/48x48/apps
	newins contrib/icon48x48.xpm alevt.xpm

	make_desktop_entry alevt "AleVT" alevt
}
