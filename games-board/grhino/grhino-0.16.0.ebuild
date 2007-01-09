# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/grhino/grhino-0.16.0.ebuild,v 1.4 2007/01/09 23:57:00 tupone Exp $

inherit eutils games

DESCRIPTION="Reversi game for GNOME, supporting the Go/Game Text Protocol"
HOMEPAGE="http://rhino.sourceforge.net/"
SRC_URI="mirror://sourceforge/rhino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome gtp"

DEPEND="gnome? ( =gnome-base/libgnomeui-2* )"

src_compile() {
	if use gnome || use gtp; then
		egamesconf \
			$(use_enable gnome) \
			$(use_enable gtp) \
			|| die "egamesconf failed"
	else
		egamesconf --enable-gtp || die "egamesconf failed"
	fi
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"

	dodoc ChangeLog NEWS README TODO || die "installing docs failed"

	if use gnome; then
		doicon ${PN}.png
		make_desktop_entry ${PN} "GRhino" ${PN}.png
	fi

	prepgamesdirs
}
