# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2.97.ebuild,v 1.8 2005/10/15 07:40:56 mkennedy Exp $

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/FoldingMode"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc-macos x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"
