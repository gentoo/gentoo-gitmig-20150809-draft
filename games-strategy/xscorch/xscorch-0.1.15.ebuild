# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xscorch/xscorch-0.1.15.ebuild,v 1.2 2004/02/03 20:35:35 mr_bones_ Exp $

inherit games

DESCRIPTION="clone of the classic DOS game, 'Scorched Earth'"
SRC_URI="http://chaos2.org/xscorch/${P}.tar.gz
	http://utoxin.kydance.net/xscorch/${P}.tar.gz"
HOMEPAGE="http://chaos2.org/xscorch/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"
IUSE="gtk mikmod readline gnome"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	mikmod? ( media-libs/libmikmod )
	readline? ( sys-libs/readline )
	gnome? ( gnome-base/gnome-libs )"

src_compile() {
	local myconf=""
	use mikmod \
		&& myconf="--enable-sound=yes" \
		|| myconf="--enable-sound=no"
	egamesconf \
		--enable-network \
		--with-readline=maybe \
		`use_with gtk` \
		`use_with gnome` \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
