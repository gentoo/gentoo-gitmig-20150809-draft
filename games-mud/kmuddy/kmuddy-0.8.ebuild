# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-0.8.ebuild,v 1.2 2007/05/19 20:54:44 opfer Exp $

inherit kde-functions

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://kmuddy.net/"
SRC_URI="http://kmuddy.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="arts sdl"

DEPEND="arts? ( kde-base/arts )
	sdl? ( media-libs/sdl-mixer )"

need-kde 3

src_compile() {
	econf \
		$(use_with arts) \
		$(use_with sdl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CHANGELOG DESIGN README README.MIDI Scripting-HOWTO TODO
}
