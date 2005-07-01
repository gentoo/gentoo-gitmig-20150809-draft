# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2.97.ebuild,v 1.6 2005/07/01 18:14:57 mkennedy Exp $

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
# HOMEPAGE is not reachable but no other suitable site found
HOMEPAGE="http://user.it.uu.se/~andersl/emacs.shtml#folding"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc-macos x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"
