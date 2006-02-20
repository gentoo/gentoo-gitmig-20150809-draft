# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/hengband/hengband-1.6.2.ebuild,v 1.2 2006/02/20 20:17:40 tupone Exp $

inherit games

DESCRIPTION="An Angband variant, with a Japanese/fantasy theme"
HOMEPAGE="http://hengband.sourceforge.jp/en/"
SRC_URI="mirror://sourceforge.jp/hengband/10331/${P}.tar.bz2"

KEYWORDS="ppc x86"
LICENSE="Moria"
SLOT="0"
IUSE="cjk X"

RDEPEND=">=sys-libs/ncurses-5
	X? ( || ( x11-libs/libX11 virtual/x11 ) )"
DEPEND="${RDEPEND}
	X? ( || ( x11-libs/libXt virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Removing Xaw dependency as is not used
	sed -i \
		-e '/Xaw/d' src/main-xaw.c \
			|| die "sed main-xaw failed"
	sed -i \
		-e 's|root\.|root:|' lib/*/Makefile.in \
			|| die "sed Makefile.in failed"
	sed -i \
		-e 's:/games/:/:g' configure \
			|| die "sed configure failed"
}

src_compile() {
	egamesconf \
		--with-setgid=${GAMES_GROUP} \
		`use_enable cjk japanese` \
		`use_with X x` \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	if use cjk ; then
		dodoc readme.txt autopick.txt readme_eng.txt autopick_eng.txt
	else
		newdoc readme_eng.txt readme.txt
		newdoc autopick_eng.txt autopick.txt
	fi
	prepgamesdirs
	# FIXME: we need to patch around this BS
	fperms g+w ${GAMES_DATADIR}/${PN}/lib/{apex,data,save,user}
}
