# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ibuffer/ibuffer-1.9.ebuild,v 1.6 2004/09/02 13:37:39 dholm Exp $

inherit elisp

IUSE=""

# Rumor has it this package will be part of FSF GNU Emacs soon...

DESCRIPTION="Operate on buffers like dired"
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/emacs"

SITEFILE=50ibuffer-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/ibuffer.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
