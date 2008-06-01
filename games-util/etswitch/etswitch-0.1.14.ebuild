# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/etswitch/etswitch-0.1.14.ebuild,v 1.4 2008/06/01 20:30:06 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="*nix minimizer for a few games"
HOMEPAGE="http://hem.bredband.net/b400150/"
SRC_URI="http://hem.bredband.net/b400150/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXpm
	x11-libs/libXxf86vm
	x11-libs/libXmu
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-libs/libXt
	x11-proto/xproto
	x11-proto/recordproto
	x11-proto/xf86vidmodeproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-desktop-entry.patch
}

src_compile() {
	egamesconf --datadir=/usr/share
	emake || "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
