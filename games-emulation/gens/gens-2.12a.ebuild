# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.12a.ebuild,v 1.1 2003/09/19 18:41:35 vapier Exp $

inherit games

DESCRIPTION="A Sega Genesis/CD/32X emulator"
HOMEPAGE="http://gens.consolemul.com/"
SRC_URI="mirror://sourceforge/gens/gens-rc2.tar.gz"
#Gens212a1SrcL.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.2
	app-arch/unzip
	>=dev-lang/nasm-0.98
	>=sys-apps/sed-4
	>=x11-libs/gtk+-2.0*"

S=${WORKDIR}/gens-linux-${PV}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS BUGS README
	prepgamesdirs
}
