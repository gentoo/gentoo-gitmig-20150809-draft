# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.12b.ebuild,v 1.4 2005/09/26 17:45:07 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="A Sega Genesis/CD/32X emulator"
HOMEPAGE="http://gens.consolemul.com/"
SRC_URI="mirror://sourceforge/gens/gens-rc3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/libc
	>=media-libs/libsdl-1.2
	>=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

S=${WORKDIR}/GensForLinux

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS README
	prepgamesdirs
}
