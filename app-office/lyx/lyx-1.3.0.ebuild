# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.3.0.ebuild,v 1.3 2003/03/01 01:13:50 vapier Exp $

DESCRIPTION="WYSIWYM frontend for LaTeX"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.gz"
HOMEPAGE="http://www.lyx.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="nls cups qt"

DEPEND="virtual/x11
	app-text/tetex 
	>=sys-devel/perl-5
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
	# patch to fix compile problem with glibc 2.3.1 from lyx 1.3.x branch cvs.
	# cf bugzilla.lyx.org #874.
	patch -p0 < $FILESDIR/$P-glibc31.diff
	patch -p0 < $FILESDIR/$P-autogen.sh.diff
	cp -f $FILESDIR/$P-configure.in $S/configure.in
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

	# from 1.2.x, should be rechecked:
	# -O3 and higher breaks
	export CXXFLAGS="${CXXFLAGS//-O[3..9]/-O2}"
	export CFLAGS="${CFLAGS//-O[3..9]/-O2}"

	export WANT_AUTOCONF_2_5=1
	
	#./autogen.sh
	econf ${myconf}
	emake || die "emake failed"

}

src_install() {
	einstall
	dodoc README* UPGRADING INSTALL* ChangeLog NEW COPYING ANNOUNCE ABOUT-NLS
}
