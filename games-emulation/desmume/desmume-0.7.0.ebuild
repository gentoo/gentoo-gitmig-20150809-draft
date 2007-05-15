# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/desmume/desmume-0.7.0.ebuild,v 1.1 2007/05/15 04:38:40 mr_bones_ Exp $

inherit games

DESCRIPTION="Emulator for Nintendo DS."
HOMEPAGE="http://desmume.sourceforge.net/"
SRC_URI="mirror://sourceforge/desmume/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.8.0
	gnome-base/libglade
	x11-libs/gtkglext
	virtual/opengl
	sys-libs/zlib
	dev-libs/zziplib
	media-libs/libsdl"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README README.LIN
	prepgamesdirs
}
