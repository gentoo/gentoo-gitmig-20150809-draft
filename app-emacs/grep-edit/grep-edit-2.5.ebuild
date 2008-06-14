# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/grep-edit/grep-edit-2.5.ebuild,v 1.2 2008/06/14 23:26:11 ulm Exp $

inherit elisp

DESCRIPTION="An improved interface to grep for editing"
HOMEPAGE="http://www.bookshelf.jp/"
# taken from http://www.bookshelf.jp/elc/grep-edit.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

pkg_postinst() {
	elisp-site-regen
	elog "To activate grep-edit, add the following line to your ~/.emacs file:"
	elog "   (require 'grep-edit)"
}
