# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-0.14.3-r1.ebuild,v 1.12 2009/02/04 09:54:57 tupone Exp $

inherit flag-o-matic eutils games

WPV="0.14"
DESCRIPTION="GNU BackGammon"
HOMEPAGE="http://www.gnu.org/software/gnubg/gnubg.html"
SRC_URI="ftp://alpha.gnu.org/gnu/gnubg/${P}.tar.gz
	ftp://alpha.gnu.org/gnu/gnubg/${PN}.weights-${WPV}.gz
	ftp://alpha.gnu.org/gnu/gnubg/gnubg_os0.bd.gz
	ftp://alpha.gnu.org/gnu/gnubg/gnubg_ts0.bd.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="arts esd gdbm gtk guile nas nls opengl python readline X"

# test fail - bug #132002
RESTRICT="test"

# FIXME does this need to DEPEND on netpbm?
RDEPEND=">=media-libs/freetype-2
	media-libs/libpng
	dev-libs/libxml2
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	gdbm? ( sys-libs/gdbm )
	=dev-libs/glib-2*
	gtk? (
		=x11-libs/gtk+-2*
		media-libs/libart_lgpl
		opengl? ( x11-libs/gtkglext >=media-libs/ftgl-2.1.2-r1 )
	)
	guile? ( dev-scheme/guile
		!>=dev-scheme/guile-1.8 )
	nas? ( media-libs/nas )
	nls? ( virtual/libintl )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )
	X? ( x11-libs/libXmu )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../${PN}.weights-${WPV} "${S}/${PN}.weights"
	mv ../*bd .
	sed -i 's:$(localedir):/usr/share/locale:' \
		$(find . -name 'Makefile.in*') \
		|| die "sed failed"
	epatch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-64bits.patch \
		"${FILESDIR}"/${P}-blas.patch \
		"${FILESDIR}"/${P}-as-needed.patch
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
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${PN}.weights *bd || die "doins failed"
	dodoc AUTHORS README NEWS
	newicon xpm/gnubg-big.xpm gnubg.xpm
	make_desktop_entry "gnubg -w" "GNU Backgammon" gnubg
	prepgamesdirs
}
