# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.5y.ebuild,v 1.6 2004/07/14 21:30:48 agriffis Exp $

DESCRIPTION="Bink Video! Player"
HOMEPAGE="http://www.radgametools.com/default.htm"
# No version on the archives
# SRC_URI="http://www.radgametools.com/down/Bink/BinkLinuxPlayer.zip"
SRC_URI="mirror://gentoo/${P}.zip"

DEPEND="app-arch/unzip"
RDEPEND="virtual/libc
	media-libs/libsdl
	media-libs/sdl-mixer"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

S="${WORKDIR}"

src_install() {
	into /opt
	dobin BinkPlayer || die "dobin failed"
}
