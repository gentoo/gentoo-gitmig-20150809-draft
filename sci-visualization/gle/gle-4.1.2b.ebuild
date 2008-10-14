# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/gle/gle-4.1.2b.ebuild,v 1.4 2008/10/14 11:42:37 grozin Exp $

EAPI=1

inherit eutils elisp-common qt4

MY_P=GLE-${PV}
DOC_VERSION="4.0.13"

DESCRIPTION="Graphics Layout Engine"
HOMEPAGE="http://glx.sourceforge.net/"
SRC_URI="mirror://sourceforge/glx/${MY_P}-src.zip
	doc? ( http://www.cs.kuleuven.be/~jan/gle/GLE-${DOC_VERSION}-manual.pdf
		   mirror://sourceforge/glx/GLEusersguide.pdf )
	emacs? ( http://glx.sourceforge.net/downloads/gle-emacs.el )
	vim-syntax? ( http://glx.sourceforge.net/downloads/vim_gle.zip )"

SLOT="0"
LICENSE="BSD emacs? ( GPL-2 )"
KEYWORDS="~amd64 ~x86"

IUSE="X qt4 jpeg png tiff doc emacs vim-syntax"

CDEPEND="sys-libs/ncurses
	X? ( x11-libs/libX11 )
	qt4? ( || ( x11-libs/qt-gui:4 =x11-libs/qt-4.3*:4 ) )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	emacs? ( virtual/emacs )"

DEPEND="${CDEPEND}
	app-arch/unzip"

RDEPEND="${CDEPEND}
	virtual/ghostscript
	virtual/latex-base
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )"

S="${WORKDIR}"/gle4

src_unpack() {
	unpack ${A}
	if use emacs; then
		cp "${DISTDIR}"/gle-emacs.el gle-mode.el || die "cp gle-mode.el failed"
		epatch "${FILESDIR}"/${P}-emacs.patch
	fi
}

src_compile() {
	econf $(use_with qt4 qt /usr) \
		$(use_with X x) \
		$(use_with jpeg) \
		$(use_with png) \
		$(use_with tiff)

	# emake failed in src/gui (probably qmake stuff)
	emake -j1 || die "emake failed"

	if use emacs; then
		elisp-compile "${WORKDIR}"/gle-mode.el || die
	fi
}

src_install() {
	# -jN failed to install some data files
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt

	if use qt4; then
		newicon src/gui/images/gle_icon.png gle.png
		make_desktop_entry qgle GLE gle
		newdoc src/gui/readme.txt gui_readme.txt
	fi

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/GLE-${DOC_VERSION}-manual.pdf \
			"${DISTDIR}"/GLEusersguide.pdf
	fi

	if use emacs; then
		elisp-install ${PN} "${WORKDIR}"/gle-mode.{el,elc} || die
		elisp-site-file-install "${FILESDIR}"/64gle-gentoo.el || die
	fi

	if use vim-syntax ; then
		dodir /usr/share/vim/vimfiles/ftplugins \
			/usr/share/vim/vimfiles/indent \
			/usr/share/vim/vimfiles/syntax
		cd ..
		chmod 644 ftplugin/* indent/* syntax/*
		insinto /usr/share/vim/vimfiles/ftplugins
		doins ftplugin/*
		insinto /usr/share/vim/vimfiles/indent
		doins indent/*
		insinto /usr/share/vim/vimfiles/syntax
		doins syntax/*
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
