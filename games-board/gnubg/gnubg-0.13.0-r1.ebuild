# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-0.13.0-r1.ebuild,v 1.4 2004/03/21 06:09:59 mr_bones_ Exp $

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

# FIXME does this need to DEPEND on netpbm?
RDEPEND="guile? ( dev-util/guile )
	truetype? ( =media-libs/freetype-1* )
	gtk? (
		gtk2? (
			=x11-libs/gtk+-2*
			=dev-libs/glib-2*
		)
		!gtk2? (
			=x11-libs/gtk+-1.2*
			=dev-libs/glib-1*
		)
	)
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	gdbm? ( sys-libs/gdbm )
	esd? ( media-sound/esound )
	arts? ( kde-base/arts )
	nas? ( media-libs/nas )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	nas? ( >=sys-apps/sed-4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ../${PN}.weights-${WPV} ${S}/${PN}.weights
	mv ../${PN}.bd ${S}
	if  [ `use nas` ] ; then
		# couldn't find -laudio without this.  Very odd.
		sed -i \
			-e "s:-laudio:-L/usr/X11R6/lib/ -laudio:" configure.in || \
				die "sed configure.in failed"
	fi
}

src_compile() {
	local myconf=""
	if use gtk ; then
		# doesn't make any sense to add this without gtk or gtk2
		if has_version x11-libs/gtk+extra ; then
			myconf="--with-gtkextra"
		else
			myconf="--without-gtkextra"
		fi
		# --with-gtk doesn't mean what you think it means for configuring gnubg.
		if use gtk2 ; then
			myconf="${myconf} --with-gtk --with-gtk2"
		else
			myconf="${myconf} --with-gtk --without-gtk2"
		fi
	else
		myconf="${myconf} --disable-gtktest"
	fi
	if use esd || use arts ; then
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
