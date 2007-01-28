# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/session/session-2.2a.ebuild,v 1.9 2007/01/28 04:28:38 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="When you start Emacs, Session restores various variables from your last session."
HOMEPAGE="http://emacs-session.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/emacs-session/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"

DEPEND="virtual/emacs"

S="${WORKDIR}/${PN}"

src_compile() {
	cd lisp
	elisp-compile session.el || die
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install ${FILESDIR}/50session-gentoo.el
	dodoc INSTALL README lisp/ChangeLog
}

pkg_postinst() {
	elisp-site-regen
	elog "Add the folloing to your ~/.emacs to use session:"
	elog "	(require 'session)"
	elog "	(add-hook 'after-init-hook 'session-initialize)"
}

pkg_postrm() {
	elisp-site-regen
}
