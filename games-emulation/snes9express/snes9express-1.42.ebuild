# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9express/snes9express-1.42.ebuild,v 1.10 2008/04/08 00:17:11 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A graphical interface for the X11 versions of snes9x"
HOMEPAGE="http://www.linuxgames.com/snes9express/"
SRC_URI="mirror://sourceforge/snes9express/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*"
RDEPEND="${DEPEND}
	games-emulation/snes9x"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix.patch \
		"${FILESDIR}/${P}"-gcc41.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
