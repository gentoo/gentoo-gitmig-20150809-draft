# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/preview-latex/preview-latex-0.7.8.ebuild,v 1.3 2004/06/09 13:42:28 agriffis Exp $

inherit latex-package elisp-common

DESCRIPTION="Renders embed latex environments such as math or figures in realtime"
HOMEPAGE="http://preview-latex.sourceforge.net/"
SRC_URI="mirror://sourceforge/preview-latex/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="emacs xemacs"

DEPEND="emacs? ( virtual/emacs
		>=app-emacs/auctex-11.14 )
	xemacs? ( virtual/xemacs
		>=app-xemacs/auctex-1.32 )
	virtual/ghostscript
	virtual/tetex"

src_unpack() {
	unpack ${A}
	cp -a ${P}/* ${T}
}

src_compile() {
	local myconf

	if use emacs || use xemacs; then
		if use emacs; then
			econf --with-emacs \
				--with-lispdir=${D}/usr/share/emacs/site-lisp/${PN} \
				|| die
			emake || die
		fi
		if use xemacs; then
			cd ${T}
			econf --with-xemacs \
				--with-packagedir=${D}/usr/lib/xemacs/site-packages \
				|| die
			emake || die
		fi
	else
		econf || die
		emake || die
	fi
}

src_install() {
	# hack.- we cant call texhash within the make install because of
	# sandbox violations. doing it later by hand
	einstall texmfdir=${D}${TEXMF} TEXHASH=/bin/true || die
	dodoc ChangeLog FAQ INSTALL PROBLEMS README RELEASE TODO doc/preview-latex.dvi

	if use emacs ; then
		elisp-site-file-install ${FILESDIR}/60preview-latex-gentoo.el
	fi

	if use xemacs; then
		cd ${T}
		einstall texmfdir=${D}${TEXMF} TEXHASH=/bin/true || die
	fi
}

pkg_postinst() {
	latex-package_pkg_postinst
	use emacs && elisp-site-regen
}

pkg_postrm() {
	latex-package_pkg_postrm
	use emacs && elisp-site-regen
}
