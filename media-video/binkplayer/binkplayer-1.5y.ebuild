# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.5y.ebuild,v 1.1 2003/11/17 21:42:59 mr_bones_ Exp $

S="${WORKDIR}"
DESCRIPTION="Bink Video! Player"
HOMEPAGE="http://www.radgametools.com/default.htm"
# No version on the archives
# SRC_URI="http://www.radgametools.com/down/Bink/BinkLinuxPlayer.zip"
SRC_URI="mirror://gentoo/${P}.zip"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/smpeg
	media-libs/libogg
	media-libs/libvorbis
	media-libs/nas
	sys-libs/slang
	media-libs/aalib
	media-libs/libgii
	dev-libs/DirectFB
	media-libs/libsdl
	media-libs/sdl-mixer"

KEYWORDS="-* ~x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

src_install () {
	dobin BinkPlayer || die "dobin failed"
}
