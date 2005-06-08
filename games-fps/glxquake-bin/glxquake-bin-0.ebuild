# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/glxquake-bin/glxquake-bin-0.ebuild,v 1.2 2005/06/08 18:41:10 mr_bones_ Exp $

inherit games

DESCRIPTION="a binary that works with every 3D-graphics-card that supports the glx X-extension"
HOMEPAGE="http://mfcn.ilo.de/glxquake/"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/shared/glxquake/glxquake.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/opengl"

S=${WORKDIR}/glxquake

src_install() {
	dogamesbin glquake || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}
