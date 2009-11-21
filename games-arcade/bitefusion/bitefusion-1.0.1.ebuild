# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bitefusion/bitefusion-1.0.1.ebuild,v 1.5 2009/11/21 17:54:16 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A snake game with 15 levels"
HOMEPAGE="http://www.junoplay.com"
SRC_URI="http://www.junoplay.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl"

# just to avoid QA notice
PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc AUTHORS
	make_desktop_entry bitefusion "Bitefusion"
	prepgamesdirs
}
