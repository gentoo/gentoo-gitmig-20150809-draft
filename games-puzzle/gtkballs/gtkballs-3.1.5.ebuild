# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtkballs/gtkballs-3.1.5.ebuild,v 1.1 2005/04/02 07:06:25 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="An entertaining game based on the old DOS game lines"
HOMEPAGE="http://gtkballs.antex.ru/"
SRC_URI="http://gtkballs.antex.ru/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-2*
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp gnome-gtkballs.png ${PN}.png || die "cp failed"
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README* TODO NEWS || die "dodoc failed"
	doicon ${PN}.png
	make_desktop_entry gtkballs "GTK Balls"
	prepgamesdirs
}
