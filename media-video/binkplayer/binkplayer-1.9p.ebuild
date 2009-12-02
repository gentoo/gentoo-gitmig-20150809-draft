# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.9p.ebuild,v 1.2 2009/12/02 10:53:34 maekke Exp $

DESCRIPTION="Bink Video! Player"
HOMEPAGE="http://www.radgametools.com/default.htm"
# No version on the archives and upstream has said they are not
# interested in providing versioned archives.
# SRC_URI="http://www.radgametools.com/down/Bink/BinkLinuxPlayer.zip"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND="app-arch/unzip"
RDEPEND="amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-compat
	)
	x86? (
		media-libs/libsdl
		media-libs/sdl-mixer
		~virtual/libstdc++-3.3
	)"

S=${WORKDIR}

src_install() {
	into /opt
	dobin BinkPlayer || die "dobin failed"
}
