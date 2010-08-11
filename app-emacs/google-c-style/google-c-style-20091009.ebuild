# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/google-c-style/google-c-style-20091009.ebuild,v 1.1 2010/08/11 03:31:35 phajdan.jr Exp $

inherit elisp

IUSE=""

DESCRIPTION="Provides the google C/C++ coding style."
HOMEPAGE="http://code.google.com/p/google-styleguide/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""
RDEPEND=""

pkg_postinst() {
	einfo "Example usage (.emacs):"
	einfo "(require 'google-c-style)"
	einfo "(add-hook 'c-mode-common-hook 'google-set-c-style)"
	einfo "(add-hook 'c-mode-common-hook 'google-make-newline-indent)"
}
