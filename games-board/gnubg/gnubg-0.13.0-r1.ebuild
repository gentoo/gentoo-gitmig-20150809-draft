# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-0.13.0-r1.ebuild,v 1.1 2003/09/30 05:41:34 mr_bones_ Exp $

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
IUSE="gtk gtk2 readline guile X gdbm truetype nls png esd arts nas"

DEPEND="guile? ( dev-util/guile )
	truetype? ( =media-libs/freetype-1* )
	|| (
		gtk? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1* )
		gtk2? ( =x11-libs/gtk+-2* =dev-libs/glib-2* )
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
	if [ -n "`use gtk`" -o -n "`use gtk2`" ] ; then
		# doesn't make any sense to add this without gtk or gtk2
		if [ -n "`best_version x11-libs/gtk+extra`" ] ; then
			myconf="--with-gtkextra"
		else
			myconf="--without-gtkextra"
		fi
		# --with-gtk doesn't mean what you think it means for configuring gnubg.
		if [ `use gtk2` ] ; then
			myconf="${myconf} --with-gtk --with-gtk2"
		else
			myconf="${myconf} --with-gtk --without-gtk2"
		fi
	else
		myconf="${myconf} --disable-gtktest"
	fi
	if [ -n "`use esd`" -o -n "`use arts`" -o -n "`use nas`" ] ; then
		myconf="${myconf} --with-sound"
	else
		myconf="${myconf} --without-sound --disable-esdtest --disable-artsc-test"
	fi

	# configure script doesn't handle this option correctly.
	#	`use_with guile` \
	egamesconf \
		`use_enable esd` \
		`use_enable arts artsc` \
		`use_enable nas` \
		`use_with readline` \
		`use_with X x` \
		`use_with gdbm` \
		`use_with truetype freetype` \
		`use_enable nls` \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	insinto ${GAMES_DATADIR}/${PN}
	doins ${PN}.weights
	dodoc AUTHORS README NEWS
	prepgamesdirs
}
