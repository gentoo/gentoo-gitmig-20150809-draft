# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.2.1.ebuild,v 1.12 2003/04/23 00:34:15 vladimir Exp $

DESCRIPTION="WYSIWYM frontend for LaTeX"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.gz"
HOMEPAGE="http://www.lyx.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="nls cups"

# This lyx-base ebuild only depends on the absolutely necessary packages.
# The acompanying lyx-utils ebuild depends on lyx-base and on everything
# else that lyx can use.
DEPEND="virtual/x11
	=x11-libs/xforms-1*
	app-text/tetex 
	>=dev-lang/perl-5
	nls? ( sys-devel/gettext )
	app-text/aiksaurus"
RDEPEND="${DEPEND}
	app-text/ghostscript
	app-text/xpdf
	virtual/aspell-dict
	app-text/gv
	app-text/latex2html
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/rcs
	dev-util/cvs
	app-text/sgmltools-lite
	app-text/noweb
	app-text/chktex"

src_compile() {
	use nls || myconf="${myconf} --disable-nls"
	[ -n "$DEBUG" ] && myconf="$myconf --enable-debug" || myconf="$myconf --disable-debug"
	
	# -O3 and higher breaks
	export CXXFLAGS="${CXXFLAGS//-O[3..9]/-O2}"
	export CFLAGS="${CFLAGS//-O[3..9]/-O2}"

	export WANT_AUTOCONF_2_5=1
	
	#./autogen.sh
	
	econf ${myconf}
		#--infodir='$(prefix)/share/info' \
		#--with-extra-inc=/usr/X11R6/include \
		#--mandir='$(prefix)/share/man' \
	emake || die "emake failed"
}

src_install() {
	# The 'install-strip' target is provided by the LyX makefile
	# for stripping installed binaries.  Use prefix= instead of
	# DESTDIR=, otherwise it violates the sandbox in the po directory.
	einstall
	dodoc README* UPGRADING INSTALL* ChangeLog NEW COPYING ANNOUNCE ABOUT-NLS
}
