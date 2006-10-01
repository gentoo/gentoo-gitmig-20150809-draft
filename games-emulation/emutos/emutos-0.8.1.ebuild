# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/emutos/emutos-0.8.1.ebuild,v 1.1 2006/10/01 21:14:20 mr_bones_ Exp $

inherit games

DESCRIPTION="a single-user single-tasking operating system for 32 bit Atari computer emulators"
HOMEPAGE="http://emutos.sourceforge.net"
SRC_URI="mirror://sourceforge/emutos/emutos512k-${PV}.zip
	mirror://sourceforge/emutos/emutos256k-${PV}.zip
	mirror://sourceforge/emutos/emutos192k-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="app-arch/unzip"

src_install() {
	dogameslib *.img || die "dogameslib failed"
	dodoc doc/{announce,authors,changelog,status}.txt readme.txt
	( cd ../emutos192k-${PV}; dogameslib *.img ) || die "dogameslib failed"
	prepgamesdirs
}
