# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.6b.ebuild,v 1.2 2004/02/27 19:11:53 mr_bones_ Exp $

DESCRIPTION="Bink Video! Player"
HOMEPAGE="http://www.radgametools.com/default.htm"
# No version on the archives and upstream has said they are not
# interested in providing versioned archives.
# SRC_URI="http://www.radgametools.com/down/Bink/BinkLinuxPlayer.zip"
SRC_URI="mirror://gentoo/${P}.zip"

DEPEND="app-arch/unzip"
RDEPEND="virtual/glibc
	media-libs/libsdl
	media-libs/sdl-mixer"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"

S="${WORKDIR}"

src_install() {
	into /opt
	dobin BinkPlayer || die "dobin failed"
}
