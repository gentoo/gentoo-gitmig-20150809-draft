# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/hengband/hengband-1.6.0.ebuild,v 1.1 2004/02/03 10:02:12 mr_bones_ Exp $

inherit games

DESCRIPTION="An Angband variant, with a Japanese/fantasy theme"
HOMEPAGE="http://hengband.sourceforge.jp/en/"
SRC_URI="ftp://clockwork.dementia.org/angband/Variant/Hengband/${P}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="Moria"
SLOT="0"
IUSE="cjk X"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
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
	if [ `use cjk` ] ; then
		dodoc readme.txt autopick.txt readme_eng.txt autopick_eng.txt
	else
		newdoc readme_eng.txt readme.txt
		newdoc autopick_eng.txt autopick.txt
	fi
	prepgamesdirs
	# FIXME: we need to patch around this BS
	fperms g+w ${GAMES_DATADIR}/${PN}/lib/{apex,data,save,user}
}
