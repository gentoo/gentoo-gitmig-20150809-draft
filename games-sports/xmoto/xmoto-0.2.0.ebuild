# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/xmoto/xmoto-0.2.0.ebuild,v 1.1 2006/08/13 20:50:46 genstef Exp $

inherit games eutils

DESCRIPTION="A challenging 2D motocross platform game"
HOMEPAGE="http://xmoto.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	app-arch/bzip2
	media-libs/libsdl
	media-libs/sdl-mixer
	net-misc/curl
	dev-lang/lua
	dev-games/ode
	virtual/opengl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/xmoto-as-needed.patch"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc README TODO ChangeLog
	prepgamesdirs
	make_desktop_entry xmoto Xmoto
}
