# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.12a.ebuild,v 1.7 2004/07/01 11:14:31 eradicator Exp $

inherit games

DESCRIPTION="A Sega Genesis/CD/32X emulator"
HOMEPAGE="http://gens.consolemul.com/"
SRC_URI="mirror://sourceforge/gens/gens-rc2.tar.gz"
#Gens212a1SrcL.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/libc
	>=media-libs/libsdl-1.2
	>=x11-libs/gtk+-2.0*"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98
	>=sys-apps/sed-4"

S="${WORKDIR}/gens-linux-${PV}"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:-DGTK_DISABLE_DEPRECATED::" ${S}/configure \
			|| die "sed configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS README
	prepgamesdirs
}
