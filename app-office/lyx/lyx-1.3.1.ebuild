# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.3.1.ebuild,v 1.1 2003/03/19 15:17:33 danarmak Exp $

DESCRIPTION="WYSIWYM frontend for LaTeX"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.gz"
HOMEPAGE="http://www.lyx.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"
IUSE="nls cups qt"

DEPEND="virtual/x11
	app-text/tetex 
	>=dev-lang/perl-5
	nls? ( sys-devel/gettext )
	app-text/aiksaurus
	qt? ( >=x11-libs/qt-3 ) !qt? ( =x11-libs/xforms-1* )"
RDEPEND="${DEPEND}
	app-text/ghostscript
	app-text/xpdf
	app-text/aspell
	app-text/gv
	app-text/latex2html
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/rcs
	dev-util/cvs
	app-text/sgmltools-lite
	app-text/noweb
	app-text/chktex"

src_unpack() {
	unpack ${A}
	cd ${S}
	#cp -f $FILESDIR/$P-configure.in $S/configure.in
}

src_compile() {
	use nls || myconf="${myconf} --disable-nls"
	if [ -n "`use qt`" ]; then
		inherit kde-functions
		set-qtdir 3
		myconf="$myconf --with-frontend=qt --with-qt-dir=${QTDIR}"
	else
		myconf="$myconf --with-frontend=xforms"
	fi
	[ -n "$DEBUG" ] && myconf="$myconf --enable-debug" || myconf="$myconf --disable-debug"

	export WANT_AUTOCONF_2_5=1

	flags="${CFLAGS}"
	unset CFLAGS
	unset CXXFLAGS
	econf ${myconf} --enable-optimization="$flags"

	emake || die "emake failed"

}

src_install() {
	einstall
	dodoc README* UPGRADING INSTALL* ChangeLog NEW COPYING ANNOUNCE ABOUT-NLS
}

pkg_postinst() {

	if [ -n "`use qt`" ]; then
		einfo	"WARNING: the QT gui, together with xft2+fontconfig (which you"
		einfo	"almost certainly have), suffer from one infamous bug that causes"
		einfo	"the matheditor not to display any special characters (the ones from"
		einfo	"the Computer Modern font family). Generated documents (.dvi, .ps...)"
		einfo	"are ok, since tex has right fonts from the bluesky package."
		einfo	"A proper solution is being busily worked on."
	fi

}

