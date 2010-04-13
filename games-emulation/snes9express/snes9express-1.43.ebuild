# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9express/snes9express-1.43.ebuild,v 1.1 2010/04/13 01:28:08 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A graphical interface for the X11 versions of snes9x"
HOMEPAGE="http://www.linuxgames.com/snes9express/"
SRC_URI="mirror://sourceforge/snes9express/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
PDEPEND="games-emulation/snes9x"

PATCHES=( "${FILESDIR}"/${P}-as-needed.patch )

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	echo snsp > "${D}${GAMES_DATADIR}/${PN}/defaultskin"
	dodoc AUTHORS ChangeLog NEWS README
	make_desktop_entry ${PN} Snes9express
	prepgamesdirs
}
