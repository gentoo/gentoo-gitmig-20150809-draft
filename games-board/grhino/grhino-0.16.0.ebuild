# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/grhino/grhino-0.16.0.ebuild,v 1.5 2007/06/11 13:51:25 nyhm Exp $

inherit eutils games

DESCRIPTION="Reversi game for GNOME, supporting the Go/Game Text Protocol"
HOMEPAGE="http://rhino.sourceforge.net/"
SRC_URI="mirror://sourceforge/rhino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome gtp nls"

RDEPEND="gnome? ( =gnome-base/libgnomeui-2* )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^(\|locale\|help\|omf\|icon\|)/s:@datadir@:/usr/share:' \
		Makefile.in \
		|| die "sed failed"
}

src_compile() {
	if use gnome || use gtp; then
		egamesconf \
			--localedir=/usr/share/locale \
			$(use_enable gnome) \
			$(use_enable gtp) \
			$(use_enable nls) \
			|| die
	else
		egamesconf \
			--enable-gtp \
			--disable-gnome \
			--localedir=/usr/share/locale \
			$(use_enable nls) \
			|| die
	fi
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog NEWS README TODO

	if use gnome; then
		make_desktop_entry ${PN} GRhino
	fi

	prepgamesdirs
}
