# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-0.13.0.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games

WPV=0.13
DESCRIPTION="GNU BackGammon"
HOMEPAGE="http://www.gnu.org/software/gnubg/gnubg.html"
SRC_URI="ftp://alpha.gnu.org/gnu/gnubg/${P}.tar.gz
	ftp://alpha.gnu.org/gnu/gnubg/${PN}.weights-${WPV}.gz
	ftp://alpha.gnu.org/gnu/gnubg/${PN}.bd.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk gtk2 readline guile X gdbm truetype nls png"

DEPEND="guile? ( dev-util/guile )
	truetype? ( =media-libs/freetype-1* )
	|| (
		gtk? ( =x11-libs/gtk+-1.2* )
		gtk2? ( =x11-libs/gtk+-2* )
	)
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	gdbm? ( sys-libs/gdbm )
	png? ( media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ../${PN}.weights-${WPV} ${S}/${PN}.weights
	mv ../${PN}.bd ${S}
}

src_compile() {
	local myconf=""
	[ -n "`best_version x11-libs/gtk+extra`" ] && myconf="--with-gtkextra"
	if [ `use esd` ] ; then
		myconf="${myconf} --with-sound --enable-esd"
	elif [ `use arts` ] ; then
		myconf="${myconf} --with-sound --enable-artsc"
	elif [ `use nas` ] ; then
		myconf="${myconf} --with-sound --enable-nas"
	else
		myconf="${myconf} --without-sound"
	fi

	#configure script doesnt hanlde this param properly
	#	`use_with guile` \
	egamesconf \
		`use_with gtk` \
		`use_with gtk2` \
		`use_with readline` \
		`use_with X x` \
		`use_with gdbm` \
		`use_with truetype freetype` \
		`use_enable nls` \
		${myconf} \
		|| die
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	insinto ${GAMES_DATADIR}/${PN}
	doins ${PN}.weights
	dodoc AUTHORS README NEWS
	prepgamesdirs
}
