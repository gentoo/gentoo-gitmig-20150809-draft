# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-0.8.ebuild,v 1.5 2008/01/24 05:50:25 mr_bones_ Exp $

inherit eutils kde-functions

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://www.kmuddy.com/"
SRC_URI="http://www.kmuddy.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="arts sdl"

DEPEND="arts? ( kde-base/arts )
	sdl? ( media-libs/sdl-mixer )"

need-kde 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${P}-nocrash.patch" \
		"${FILESDIR}/${P}-idle-crash.patch"
}

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
