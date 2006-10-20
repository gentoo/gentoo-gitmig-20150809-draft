# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.2.7.ebuild,v 1.14 2006/10/20 22:14:59 tupone Exp $

inherit eutils games

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.tim-mann.org/xboard.html"
SRC_URI="mirror://gnu/xboard/${P}.tar.gz
	mirror://gentoo/${PN}.png
	http://dev.gentoo.org/~wolf31o2/sources/dump/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""
RESTRICT="test" #124112

RDEPEND="games-board/gnuchess
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXext
	x11-libs/libICE
	x11-libs/libXpm
	x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}*
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc FAQ READ_ME ToDo ChangeLog*
	dohtml FAQ.html
	doicon ${DISTDIR}/xboard.png
	make_desktop_entry ${PN} "Xboard (Chess)"
	prepgamesdirs
}
