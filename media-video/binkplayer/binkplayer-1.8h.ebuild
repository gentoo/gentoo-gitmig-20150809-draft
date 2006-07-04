# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.8h.ebuild,v 1.3 2006/07/04 04:44:05 squinky86 Exp $

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

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	amd64? ( app-emulation/emul-linux-x86-sdl )"

S=${WORKDIR}

src_install() {
	into /opt
	dobin BinkPlayer || die "dobin failed"
}
