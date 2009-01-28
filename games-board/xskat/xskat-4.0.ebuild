# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xskat/xskat-4.0.ebuild,v 1.8 2009/01/28 23:40:55 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Famous german card game"
HOMEPAGE="http://www.xskat.de/xskat.html"
SRC_URI="http://www.xskat.de/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="x11-libs/libX11
	media-fonts/font-misc-misc"
DEPEND="${RDEPEND}
	x11-misc/gccmakedep
	x11-misc/imake
	x11-proto/xproto"

src_compile() {
	xmkmf -a || die "xmkmf failed"
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin xskat || die "dogamesbin failed"
	newman xskat.man xskat.6
	dodoc CHANGES README{,.IRC}
	newicon icon.xbm ${PN}.xbm
	make_desktop_entry ${PN} XSkat /usr/share/pixmaps/${PN}.xbm
	prepgamesdirs
}
