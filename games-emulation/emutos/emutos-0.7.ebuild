# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/emutos/emutos-0.7.ebuild,v 1.4 2004/02/29 10:30:37 vapier Exp $

inherit games

DESCRIPTION="a single-user single-tasking operating system for 32 bit Atari computer emulators"
HOMEPAGE="http://emutos.sourceforge.net"
SRC_URI="mirror://sourceforge/emutos/etos512k-${PV}.zip
	mirror://sourceforge/emutos/etos256k-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="app-arch/unzip"

S=${WORKDIR}/${PN}

src_install() {
	dogameslib *.img
	dodoc doc/{announce,authors,changelog,readme,status}.txt
	prepgamesdirs
}
