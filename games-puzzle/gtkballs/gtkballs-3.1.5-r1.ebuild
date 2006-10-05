# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtkballs/gtkballs-3.1.5-r1.ebuild,v 1.2 2006/10/05 18:15:42 nyhm Exp $

inherit eutils games

DESCRIPTION="An entertaining game based on the old DOS game lines"
HOMEPAGE="http://gtkballs.antex.ru/"
SRC_URI="http://gtkballs.antex.ru/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-2*
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^nlsdir=/s:=.*:=/usr/share/locale:' \
		-e '/^localedir/s:=.*:=/usr/share/locale:' \
		configure po/Makefile.in.in || die "sed locale failed"
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README* TODO NEWS || die "dodoc failed"
	newicon gnome-gtkballs.png ${PN}.png
	make_desktop_entry gtkballs "GTK Balls"
	prepgamesdirs
}
