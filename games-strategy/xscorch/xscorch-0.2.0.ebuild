# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xscorch/xscorch-0.2.0.ebuild,v 1.1 2004/03/26 11:05:12 mr_bones_ Exp $

inherit games

DESCRIPTION="clone of the classic DOS game, 'Scorched Earth'"
HOMEPAGE="http://chaos2.org/xscorch/"
SRC_URI="http://chaos2.org/xscorch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha"
IUSE="gtk mikmod gnome" #readline

#readline? ( sys-libs/readline )
DEPEND="gtk? ( =x11-libs/gtk+-1* )
	mikmod? ( media-libs/libmikmod )
	gnome? ( gnome-base/gnome-libs )"

src_compile() {
	#configure failed on readline support
	egamesconf \
		--enable-network \
		--without-readline \
		`use_enable mikmod sound` \
		`use_with gtk` \
		`use_with gnome` \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	# remove unneeded, empty directory
	rmdir ${D}/usr/games/include
	prepgamesdirs
}
