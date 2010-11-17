# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/undo-tree/undo-tree-0.1.7_pre20101117-r1.ebuild,v 1.1 2010/11/17 22:11:16 tomka Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="undo trees and visualization"
HOMEPAGE="http://www.dr-qubit.org/emacs.php#undo-tree"
SRC_URI="mirror://gentoo/${P}.el.bz2
		 http://dev.gentoo.org/~tomka/files/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

pkg_postinst() {
		elisp-site-regen

		einfo "To enable undo trees globally place '(global-undo-tree-mode)'"
		einfo "in your .emacs file."
}
