# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/construo/construo-0.2.2.ebuild,v 1.6 2005/04/04 00:08:56 mr_bones_ Exp $

inherit games

DESCRIPTION="2d construction toy with objects that react on physical forces"
HOMEPAGE="http://www.nongnu.org/construo/"
SRC_URI="http://freesoftware.fsf.org/download/construo/construo.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="virtual/x11
	sys-libs/zlib
	virtual/glut"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:<math.h>:<cmath>:g' vector.cxx \
		|| die "sed failed"

}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		bindir="${GAMES_BINDIR}" install \
		|| die "make install failed"
	dodoc AUTHORS INSTALL INSTALL.configure NEWS README TODO
	prepgamesdirs
}
