# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/maxima/maxima-5.9.0-r1.ebuild,v 1.4 2003/11/15 07:10:51 seemant Exp $

DESCRIPTION="Free computer algebra environment, based on Macsyma"
HOMEPAGE="http://maxima.sourceforge.net/"
SRC_URI="http://dl.sourceforge.net/sourceforge/maxima/maxima-${PV}.tar.gz"

LICENSE="GPL-2 AECA"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="cmucl clisp gcl tetex emacs auctex"


DEPEND="tetex? ( app-text/tetex )
	emacs? ( virtual/emacs )
	auctex? ( app-emacs/auctex )
	>=sys-apps/texinfo-4.3
	!clisp?	( !gcl? ( !cmucl? ( dev-lisp/cmucl-bin ) ) )
	clisp? ( dev-lisp/clisp )
	cmucl? ( dev-lisp/cmucl-bin )
	gcl?   ( dev-lisp/gcl )"

RDEPEND=">=dev-lang/tk-8.3.3"


src_compile() {
	local myconf=""
	if [ -n "$(use cmucl)" ] || [ -n "$(use clisp)" ] || [ -n "$(use gcl)" ]; then
		if [ -n "$(use cmucl)" ]; then
			myconf="${myconf} --enable-cmucl"
		fi
		if [ -n "$(use clisp)" ]; then
			myconf="${myconf} --enable-clisp"
		fi
		if [ -n "$(use gcl)" ]; then
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
	if [ -n "`use emacs`" ]
	then
		elisp-install ${S}/interfaces/emacs/emaxima *.el *.elc
		insinto /usr/share/emacs/site-lisp
		doins ${S}/interfaces/emacs/emaxima/emaxima.lisp
	fi
	if [ -n "`use tetex`" ]
	then
		insinto /usr/share/texmf/tex/latex/emaxima
		doins ${S}/interfaces/emacs/emaxima/emaxima.sty
	fi
	#move docs to the appropriate place
	dodoc AUTHORS ChangeLog COPYING COPYING1 NEWS README*
	mv ${D}/usr/share/${PN}/${PV}/doc/* ${D}/usr/share/doc/${PF}/
}

pkg_postinst() {
	if [ -n "`use emacs`" ]
	then
		einfo "Running elisp-site-regen...."
		elisp-site-regen
	fi
	if [ -n "`use tetex`" ]
	then
		einfo "Running mktexlsr to rebuild ls-R database...."
		mktexlsr
	fi
	if [ -n "`use emacs`" ]
	then
		einfo "In order to use Maxima with emacs, add the following to your"
		einfo ".emacs file:"
		einfo "(setq load-path (cons "/usr/share/maxima/5.9.0/emacs" load-path))"
		einfo "(autoload 'maxima-mode "maxima" "Maxima mode" t)"
		einfo "(autoload 'maxima "maxima" "Maxima interactive" t)"
		einfo "(setq auto-mode-alist (cons '("\\.max" . maxima-mode) auto-mode-alist))"
		einfo "(autoload 'emaxima-mode "emaxima" "EMaxima" t)"
		einfo "(add-hook 'emaxima-mode-hook 'emaxima-mark-file-as-emaxima)"
	fi
}
