# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/angband/angband-3.0.3.ebuild,v 1.5 2004/03/31 06:39:06 mr_bones_ Exp $

inherit games

DESCRIPTION="A Roguelike adventure game"
HOMEPAGE="http://thangorodrim.net/"
SRC_URI="ftp://clockwork.dementia.org/${PN}/Source/${P}.tar.gz"

LICENSE="Moria"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="X"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	local myconf="--bindir=/usr/games/bin --with-setgid=games"
	myconf="${myconf} `use_with X x`"
	sed -i \
		-e "s:/games/:/:" configure \
			|| die "sed configure failed"
	chmod +x configure
	egamesconf ${myconf} || die "configure failed"
	emake || die "make failed"
}

pkg_preinst() {
	rm "${D}/usr/share/games/angband/lib/apex/scores.raw"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS THANKS TODO changes.txt compile.txt readme.txt
	prepgamesdirs
}

pkg_postinst() {
	chmod -R g+w "${ROOT}"/usr/share/games/angband/lib/{apex,save,user}
}
