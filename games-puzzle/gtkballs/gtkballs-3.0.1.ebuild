# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtkballs/gtkballs-3.0.1.ebuild,v 1.1 2003/10/26 06:20:22 mr_bones_ Exp $

inherit games

DESCRIPTION="An entertaining game based on the old DOS game lines"
SRC_URI="http://gtkballs.antex.ru/dist/${P}.tar.gz"
HOMEPAGE="http://gtkballs.antex.ru/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="3"

RDEPEND="=x11-libs/gtk+-2*
	nls? ( >=sys-devel/gettext-0.10.38 ) "
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

IUSE="nls"

src_unpack() {
	unpack ${A}

	sed -i \
		-e 's/__func__/__FUNCTION__/g' ${S}/src/themerc.c || \
			die "sed src/themerc.c failed"
}

src_compile() {
	egamesconf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	dodoc ChangeLog AUTHORS README* TODO NEWS
	prepgamesdirs
}
