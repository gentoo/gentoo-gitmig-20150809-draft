# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/google-c-style/google-c-style-20091009-r1.ebuild,v 1.1 2010/08/11 08:36:31 ulm Exp $

inherit elisp

DESCRIPTION="Provides the google C/C++ coding style"
HOMEPAGE="http://code.google.com/p/google-styleguide/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

pkg_postinst() {
	elisp-site-regen

	einfo "Example usage (.emacs):"
	einfo "  (add-hook 'c-mode-common-hook 'google-set-c-style)"
	einfo "  (add-hook 'c-mode-common-hook 'google-make-newline-indent)"
}
