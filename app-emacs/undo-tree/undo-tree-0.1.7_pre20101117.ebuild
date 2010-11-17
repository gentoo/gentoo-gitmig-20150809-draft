# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/undo-tree/undo-tree-0.1.7_pre20101117.ebuild,v 1.1 2010/11/17 18:17:24 tomka Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="undo trees and vizualization"
HOMEPAGE="http://www.dr-qubit.org/emacs.php#undo-tree"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		 http://dev.gentoo.org/~tomka/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

pkg_postinst() {
	elisp-site-regen

	einfo "If you have (require 'site-gentoo) in your .emacs,"
	einfo "then undo-trees will be globally activiated for you."
}
