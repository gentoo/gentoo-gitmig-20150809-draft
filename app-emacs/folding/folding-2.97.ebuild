# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2.97.ebuild,v 1.2 2004/06/01 14:09:04 vapier Exp $

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
HOMEPAGE="http://user.it.uu.se/~andersl/emacs.shtml#folding"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"

SITEFILE="70${PN}-gentoo.el"
