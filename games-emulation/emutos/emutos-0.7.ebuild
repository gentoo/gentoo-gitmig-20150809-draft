# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/emutos/emutos-0.7.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="a single-user single-tasking operating system for 32 bit Atari computer emulators"
HOMEPAGE="http://emutos.sourceforge.net"
SRC_URI="mirror://sourceforge/emutos/etos512k-${PV}.zip
	mirror://sourceforge/emutos/etos256k-${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND="app-arch/unzip"

src_install() {
	dogameslib *.img
	dodoc doc/{announce,authors,changelog,readme,status}.txt
	prepgamesdirs
}
