# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.2.1.ebuild,v 1.18 2004/01/26 00:02:19 vapier Exp $

inherit flag-o-matic

DESCRIPTION="WYSIWYM frontend for LaTeX"
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nls cups debug"

# This lyx-base ebuild only depends on the absolutely necessary packages.
# The acompanying lyx-utils ebuild depends on lyx-base and on everything
# else that lyx can use.
DEPEND="virtual/x11
	=x11-libs/xforms-1*
	virtual/tetex
	>=dev-lang/perl-5
	nls? ( sys-devel/gettext )
	app-text/aiksaurus"
RDEPEND="${DEPEND}
	virtual/ghostscript
	app-text/xpdf
	virtual/aspell-dict
	app-text/gv
	dev-tex/latex2html
	media-gfx/imagemagick
	cups? ( virtual/lpr )
	app-text/rcs
	dev-util/cvs
	app-text/sgmltools-lite
	app-text/noweb
	dev-tex/chktex"

src_compile() {
	replace-flags -O? -O2

	econf \
		`use_enable nls` \
		`use_enable debug` \
		|| die
		#--infodir='$(prefix)/share/info' \
		#--with-extra-inc=/usr/X11R6/include \
		#--mandir='$(prefix)/share/man' \
	emake || die "emake failed"
}

src_install() {
	# The 'install-strip' target is provided by the LyX makefile
	# for stripping installed binaries.  Use prefix= instead of
	# DESTDIR=, otherwise it violates the sandbox in the po directory.
	einstall || die
	dodoc README* UPGRADING INSTALL* ChangeLog NEW COPYING ANNOUNCE
}
