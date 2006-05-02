# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-0.14.3.ebuild,v 1.5 2006/05/02 05:07:34 mr_bones_ Exp $

inherit gnuconfig flag-o-matic eutils games

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
IUSE="arts esd gdbm gtk guile nas nls opengl python readline X"

# FIXME does this need to DEPEND on netpbm?
DEPEND="dev-libs/glib
	>=media-libs/freetype-2
	media-libs/libpng
	dev-libs/libxml2
	sys-libs/zlib
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	gdbm? ( sys-libs/gdbm )
	gtk? (
		=x11-libs/gtk+-2*
		=dev-libs/glib-2*
		media-libs/libart_lgpl
		opengl? ( x11-libs/gtkglext
			media-libs/ftgl )
	)
	guile? ( dev-util/guile )
	nas? ( media-libs/nas )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )
	X? ( || ( x11-libs/libXmu virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../${PN}.weights-${WPV} "${S}/${PN}.weights"
	mv ../*bd .
	epatch \
		"${FILESDIR}/${P}"-gcc4.patch \
		"${FILESDIR}/${P}"-as-needed.patch
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
		myconf="${myconf} --with-gtk --with-gtk2"
		if use opengl ; then
			myconf="${myconf} --with-board3d"
			append-flags $(pkg-config ftgl --cflags)
			append-ldflags $(pkg-config ftgl --libs)
		else
			myconf="${myconf} --without-board3d"
		fi
	else
		myconf="${myconf} --without-gtk --disable-gtktest --without-board3d"
	fi
	if use arts || use esd ; then
		myconf="${myconf} --with-sound"
	else
		myconf="${myconf} --without-sound --disable-esdtest --disable-artsc-test"
	fi
	if ! use guile ; then
		myconf="${myconf} --without-guile"
	fi

	filter-flags -ffast-math #bug #67929

	LIBART_CONFIG="/usr/bin/libart2-config" egamesconf \
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
	newicon xpm/gnubg-big.xpm gnubg.xpm
	make_desktop_entry "gnubg -w" "GNU Backgammon" gnubg.xpm
	prepgamesdirs
}
