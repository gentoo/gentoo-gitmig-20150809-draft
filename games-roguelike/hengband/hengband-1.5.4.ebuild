# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/hengband/hengband-1.5.4.ebuild,v 1.3 2004/02/03 10:02:59 mr_bones_ Exp $

inherit games

DESCRIPTION="An Angband variant, with a Japanese/fantasy theme"
HOMEPAGE="http://hengband.sourceforge.jp/en/"
SRC_URI="ftp://clockwork.dementia.org/angband/Variant/Hengband/${P}.tar.gz"

LICENSE="Moria"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="cjk X"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's|root\.|root:|' lib/*/Makefile.in
	sed -i 's:/games/:/:g' configure
}

src_compile() {
	egamesconf \
		--with-setgid=${GAMES_GROUP} \
		`use_enable cjk japanese` \
		`use_with X x` \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	if [ `use cjk` ] ; then
		dodoc readme.txt autopick.txt
	else
		newdoc readme_eng.txt readme.txt
		newdoc autopick_eng.txt autopick.txt
	fi
	dodoc readme.txt
	prepgamesdirs
	# FIXME: we need to patch around this BS
	fperms g+w ${GAMES_DATADIR}/${PN}/lib/{apex,data,save,user}
}
