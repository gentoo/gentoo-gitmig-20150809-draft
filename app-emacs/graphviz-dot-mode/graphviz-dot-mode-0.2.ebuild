# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/graphviz-dot-mode/graphviz-dot-mode-0.2.ebuild,v 1.4 2004/06/24 22:13:04 agriffis Exp $

inherit elisp

IUSE=""
DESCRIPTION="Emacs mode for editing and previewing Graphviz dot graphs"
HOMEPAGE="http://www.research.att.com/sw/tools/graphviz/download.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/emacs"

SITEFILE=50graphviz-dot-mode-gentoo.el
