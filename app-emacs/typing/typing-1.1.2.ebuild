# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/typing/typing-1.1.2.ebuild,v 1.7 2004/08/20 21:54:43 tgall Exp $

inherit elisp

IUSE=""

DESCRIPTION='The Typing of Emacs -- an Elisp parody of The Typing of the Dead for Dreamcast'
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc64"

DEPEND="virtual/emacs"

SITEFILE=50typing-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/typing.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
