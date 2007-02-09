# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2006.1118.ebuild,v 1.2 2007/02/09 17:34:36 mr_bones_ Exp $

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/FoldingMode"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc-macos ~x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"
