# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/hengband/hengband-1.6.2-r1.ebuild,v 1.4 2010/06/04 06:32:45 tupone Exp $
EAPI="2"

inherit toolchain-funcs eutils autotools games

DESCRIPTION="An Angband variant, with a Japanese/fantasy theme"
HOMEPAGE="http://hengband.sourceforge.jp/en/"
SRC_URI="mirror://sourceforge.jp/hengband/10331/${P}.tar.bz2
	mirror://gentoo/${P}-mispellings.patch.gz"

KEYWORDS="ppc x86 ~x86-fbsd"
LICENSE="Moria"
SLOT="0"
IUSE="X linguas_ja"

RDEPEND=">=sys-libs/ncurses-5
	X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}
	X? ( x11-libs/libXt )"

src_prepare() {
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
	epatch "../${P}"-mispellings.patch	\
		"${FILESDIR}/${P}"-added_faq.patch
	eautoreconf
}

src_configure() {
	local myconf
	use linguas_ja || myconf="--disable-japanese"

	tc-export CC
	egamesconf \
		--with-setgid=${GAMES_GROUP} \
		`use_with X x` \
		${myconf} \
		|| die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	if use linguas_ja ; then
		dodoc readme.txt autopick.txt readme_eng.txt autopick_eng.txt
	else
		newdoc readme_eng.txt readme.txt
		newdoc autopick_eng.txt autopick.txt
	fi
	prepgamesdirs
	# FIXME: we need to patch around this BS
	fperms g+w "${GAMES_DATADIR}"/${PN}/lib/{apex,data,save,user}
}
