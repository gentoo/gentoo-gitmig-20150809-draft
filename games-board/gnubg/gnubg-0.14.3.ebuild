# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-0.14.3.ebuild,v 1.1 2005/02/25 03:14:06 mr_bones_ Exp $

inherit gnuconfig flag-o-matic games

WPV="0.14"
DESCRIPTION="GNU BackGammon"
HOMEPAGE="http://www.gnu.org/software/gnubg/gnubg.html"
SRC_URI="ftp://alpha.gnu.org/gnu/gnubg/${P}.tar.gz
	ftp://alpha.gnu.org/gnu/gnubg/${PN}.weights-${WPV}.gz
	ftp://alpha.gnu.org/gnu/gnubg/gnubg_os0.bd.gz
	ftp://alpha.gnu.org/gnu/gnubg/gnubg_ts0.bd.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~ppc ~sparc x86"
IUSE="arts esd gdbm guile gtk gtk2 nas nls opengl png python readline truetype X"

# FIXME does this need to DEPEND on netpbm?
DEPEND="guile? ( dev-util/guile )
	python? ( dev-lang/python )
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
		opengl? ( x11-libs/gtkglext media-libs/ftgl )
	)
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	dev-libs/glib
	gdbm? ( sys-libs/gdbm )
	esd? ( media-sound/esound )
	arts? ( kde-base/arts )
	nas? ( media-libs/nas )
	png? ( media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../${PN}.weights-${WPV} "${S}/${PN}.weights"
	mv ../*bd .
	gnuconfig_update
}

src_compile() {
	local myconf=
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
		if use opengl ; then
			myconf="${myconf} --with-board3d"
			append-flags $(pkg-config ftgl --cflags)
		fi
	else
		myconf="${myconf} --without-gtk --disable-gtktest --without-board3d"
	fi
	if use arts || use esd ; then
		myconf="${myconf} --with-sound"
	else
		myconf="${myconf} --without-sound --disable-esdtest --disable-artsc-test"
	fi
	if ! use truetype ; then
		myconf="${myconf} --with-ft=no --with-ft-exec-prefix=no --disable-freetypetest"
	fi

	filter-flags -ffast-math #bug #67929

	# configure script doesn't handle this option correctly.
	#       `use_with guile` \
	egamesconf \
		$(use_enable arts artsc) \
		$(use_enable esd) \
		$(use_with gdbm) \
		$(use_enable nas) \
		$(use_enable nls) \
		$(use_with python) \
		$(use_with readline) \
		$(use_with X x) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${PN}.weights *bd || die "doins failed"
	dodoc AUTHORS README NEWS
	prepgamesdirs
}
