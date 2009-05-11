# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/desmume/desmume-0.9.2_p1.ebuild,v 1.1 2009/05/11 17:13:27 hanno Exp $

EAPI="2"

inherit games

DESCRIPTION="Emulator for Nintendo DS."
HOMEPAGE="http://desmume.org/"
SRC_URI="mirror://sourceforge/desmume/${P/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.8.0
	gnome-base/libglade
	x11-libs/gtkglext
	virtual/opengl
	sys-libs/zlib
	dev-libs/zziplib
	media-libs/libsdl[joystick]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_p/-}"

src_compile() {
	egamesconf --datadir=/usr/share || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog README README.LIN
	prepgamesdirs
}
