# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/angband/angband-3.0.3.ebuild,v 1.3 2004/02/20 06:55:42 mr_bones_ Exp $

inherit games

DESCRIPTION="A Roguelike adventure game"
HOMEPAGE="http://thangorodrim.net/"
SRC_URI="ftp://clockwork.dementia.org/${PN}/Source/${P}.tar.gz"

LICENSE="Moria"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="X"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5
	X? ( >=x11-base/xfree-4.0 )"

src_compile() {
	local myconf="--bindir=/usr/games/bin --with-setgid=games"
	myconf="${myconf} `use_with X x`"
	sed -i "s:/games/:/:" configure || die "sed configure failed"
	chmod +x configure
	egamesconf ${myconf} || die "configure failed"
	emake || die "make failed"
}

pkg_preinst() {
	rm ${D}/usr/share/games/angband/lib/apex/scores.raw
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING THANKS TODO changes.txt compile.txt readme.txt
	prepgamesdirs
}

pkg_postinst() {
	chmod -R g+w /usr/share/games/angband/lib/{apex,save,user}
}
