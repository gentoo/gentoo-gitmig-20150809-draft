# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/boxquote/boxquote-1.18-r1.ebuild,v 1.1 2007/04/16 18:25:42 ulm Exp $

inherit elisp

DESCRIPTION="Quote text with a semi-box"
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"
IUSE=""

SITEFILE=51${PN}-gentoo.el

src_compile() {
	elisp-compile *.el || die "elisp-compile failed"
	elisp-make-autoload-file || die "elisp-make-autoload-file failed"
}
