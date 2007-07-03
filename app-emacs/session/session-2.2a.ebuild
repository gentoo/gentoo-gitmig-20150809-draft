# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/session/session-2.2a.ebuild,v 1.10 2007/07/03 06:33:18 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="When you start Emacs, Session restores various variables from your last session."
HOMEPAGE="http://emacs-session.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/emacs-session/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"

S="${WORKDIR}/${PN}"
SITEFILE=50${PN}-gentoo.el
DOCS="INSTALL README lisp/ChangeLog"

src_compile() {
	cd lisp
	elisp-compile session.el || die
}

pkg_postinst() {
	elisp-site-regen
	elog "Add the folloing to your ~/.emacs to use session:"
	elog "	(require 'session)"
	elog "	(add-hook 'after-init-hook 'session-initialize)"
}
