# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtkballs/gtkballs-3.1.0.ebuild,v 1.1 2004/01/23 01:22:07 mr_bones_ Exp $

inherit games

DESCRIPTION="An entertaining game based on the old DOS game lines"
HOMEPAGE="http://gtkballs.antex.ru/"
SRC_URI="http://gtkballs.antex.ru/dist/${P}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="=x11-libs/gtk+-2*
	nls? ( >=sys-devel/gettext-0.10.38 ) "
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

IUSE="nls"

src_compile() {
	egamesconf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README* TODO NEWS || die "dodoc failed"
	prepgamesdirs
}
