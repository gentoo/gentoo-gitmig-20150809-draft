# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/identica-mode/identica-mode-1.1-r1.ebuild,v 1.1 2011/03/07 17:23:42 ulm Exp $

EAPI=3
NEED_EMACS=23

inherit elisp

DESCRIPTION="Identi.ca mode for Emacs"
HOMEPAGE="http://blog.nethazard.net/identica-mode-for-emacs/"
# taken from: http://git.savannah.gnu.org/cgit/identica-mode.git/snapshot/${P}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ELISP_TEXINFO="doc/${PN}.texi"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp-compile ${PN}.el || die
	cd doc
	makeinfo ${ELISP_TEXINFO##*/} || die
}

pkg_postinst() {
	elisp-site-regen
	elog "You may optionally set username and password in your ~/.emacs file:"
	elog "  (setq identica-username \"yourusername\")"
	elog "  (setq identica-password \"yourpassword\")"
}
