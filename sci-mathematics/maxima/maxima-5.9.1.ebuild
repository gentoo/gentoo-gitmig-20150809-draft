# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/maxima/maxima-5.9.1.ebuild,v 1.3 2005/08/07 13:09:40 hansmi Exp $

inherit eutils

DESCRIPTION="Free computer algebra environment, based on Macsyma"
HOMEPAGE="http://maxima.sourceforge.net/"
SRC_URI="mirror://sourceforge/maxima/${P}.tar.gz"

LICENSE="GPL-2 AECA"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="cmucl clisp gcl tetex emacs auctex"

DEPEND="tetex? ( virtual/tetex )
	emacs? ( virtual/emacs )
	auctex? ( app-emacs/auctex )
	>=sys-apps/texinfo-4.3
	x86? ( !clisp?	( !gcl? ( !cmucl? ( dev-lisp/cmucl ) ) ) )
	clisp? ( dev-lisp/clisp )
	x86? ( cmucl? ( dev-lisp/cmucl ) )
	x86? ( gcl?   ( dev-lisp/gcl ) )"
RDEPEND=">=dev-lang/tk-8.3.3"

src_unpack() {
	unpack ${A}
	cd ${S}/interfaces/emacs/emaxima
	epatch ${FILESDIR}/maxima-emacs.patch
}

src_compile() {
	local myconf=""
	if use cmucl || use clisp || use gcl; then
		if use cmucl; then
			myconf="${myconf} --enable-cmucl"
		fi
		if use clisp; then
			myconf="${myconf} --enable-clisp"
		fi
		if use gcl; then
			myconf="${myconf} --enable-gcl"
		fi
	else
		myconf="${myconf} --enable-cmucl"
	fi

	./configure --prefix=/usr ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	if use emacs
	then
		elisp-install ${S}/interfaces/emacs/emaxima *.el *.elc
		insinto /usr/share/emacs/site-lisp
		doins ${S}/interfaces/emacs/emaxima/emaxima.lisp
	fi
	if use tetex
	then
		insinto /usr/share/texmf/tex/latex/emaxima
		doins ${S}/interfaces/emacs/emaxima/emaxima.sty
	fi
	#move docs to the appropriate place
	dodoc AUTHORS ChangeLog COPYING COPYING1 NEWS README*
	mv ${D}/usr/share/${PN}/${PV}/doc/* ${D}/usr/share/doc/${PF}/
}

pkg_postinst() {
	if use emacs
	then
		einfo "Running elisp-site-regen...."
		elisp-site-regen
	fi
	if use tetex
	then
		einfo "Running mktexlsr to rebuild ls-R database...."
		mktexlsr
	fi
	if use emacs
	then
		einfo "In order to use Maxima with emacs, add the following to your"
		einfo ".emacs file:"
		einfo '(setq load-path (cons "/usr/share/maxima/5.9.0/emacs" load-path))'
		einfo "(autoload 'maxima-mode \"maxima\" \"Maxima mode\" t)"
		einfo "(autoload 'maxima \"maxima\" \"Maxima interactive\" t)"
		einfo "(setq auto-mode-alist (cons '(\"\\\\.max\" . maxima-mode) auto-mode-alist))"
		einfo "(autoload 'emaxima-mode \"emaxima\" \"EMaxima\" t)"
		einfo "(add-hook 'emaxima-mode-hook 'emaxima-mark-file-as-emaxima)"
	fi
}
