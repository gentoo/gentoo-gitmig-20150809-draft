# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/table/table-1.5.54-r1.ebuild,v 1.3 2007/05/16 17:30:50 gustavoz Exp $

inherit elisp

DESCRIPTION="Table editor for Emacs"
HOMEPAGE="http://table.sourceforge.net/"
SRC_URI="mirror://sourceforge/table/${P}.el.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el
SIMPLE_ELISP=t

src_compile() {
	elisp-compile *.el || die "elisp-compile failed"
	elisp-make-autoload-file || die "elisp-make-autoload-file failed"
}
