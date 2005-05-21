# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ibuffer/ibuffer-2.6.1.ebuild,v 1.1 2005/05/21 20:43:54 usata Exp $

inherit elisp

IUSE=""

# Rumor has it this package will be part of FSF GNU Emacs soon...

DESCRIPTION="Operate on buffers like dired"
HOMEPAGE="http://www.shootybangbang.com/"
# taken from http://www.shootybangbang.com/software/ibuffer.el
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/emacs"

SITEFILE=50ibuffer-gentoo.el

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/ibuffer.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
