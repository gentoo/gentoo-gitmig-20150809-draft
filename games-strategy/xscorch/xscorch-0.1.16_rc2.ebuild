# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xscorch/xscorch-0.1.16_rc2.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit games

S="${WORKDIR}/xscorch-0.1.15"
DESCRIPTION="clone of the classic DOS game, 'Scorched Earth'"
HOMEPAGE="http://chaos2.org/xscorch/"
SRC_URI="http://chaos2.org/xscorch/${PN}-0.1.15.tar.gz
	http://utoxin.kydance.net/xscorch/${PN}-0.1.15.tar.gz
	http://chaos2.org/xscorch/xscorch-0.1.15-0.1.16pre2.patch.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha"
SLOT="0"

IUSE="gtk mikmod readline gnome"

DEPEND="virtual/x11
	gtk? ( =x11-libs/gtk+-1* )
	mikmod? ( >=media-libs/libmikmod-3.1.5 )
	readline? ( sys-libs/readline )
	gnome? ( gnome-base/gnome-libs )"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch xscorch-0.1.15-0.1.16pre2.patch
}

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
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
