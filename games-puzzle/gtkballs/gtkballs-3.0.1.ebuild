# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtkballs/gtkballs-3.0.1.ebuild,v 1.4 2004/05/12 09:02:45 mr_bones_ Exp $

inherit games

DESCRIPTION="An entertaining game based on the old DOS game lines"
SRC_URI="http://gtkballs.antex.ru/dist/${P}.tar.gz"
HOMEPAGE="http://gtkballs.antex.ru/"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="=x11-libs/gtk+-2*
	nls? ( >=sys-devel/gettext-0.10.38 ) "
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

IUSE="nls"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:touch Makefile\.in::' configure \
		|| die "sed configure failed"
	sed -i \
		-e 's/__func__/__FUNCTION__/g' src/themerc.c \
		|| die "sed src/themerc.c failed"
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	dodoc ChangeLog AUTHORS README* TODO NEWS
	prepgamesdirs
}
