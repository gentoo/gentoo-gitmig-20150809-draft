# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/glxquake-bin/glxquake-bin-0.ebuild,v 1.3 2006/03/31 03:24:46 wolf31o2 Exp $

inherit games

DESCRIPTION="a binary that works with every 3D-graphics-card that supports the glx X-extension"
HOMEPAGE="http://mfcn.ilo.de/glxquake/"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/shared/glxquake/glxquake.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RDEPEND="sys-libs/glibc
	virtual/opengl
	x86? (
		|| (
			(
				x11-libs/libX11
				x11-libs/libXext
				x11-libs/libXxf86vm
				x11-libs/libdrm
				x11-libs/libXau
				x11-libs/libXdmcp )
			virtual/x11 ) )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}/glxquake

src_install() {
	dogamesbin glquake || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}
