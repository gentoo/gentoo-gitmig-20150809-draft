# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2.97.ebuild,v 1.5 2005/01/01 13:46:12 eradicator Exp $

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
# HOMEPAGE is not reachable but no other suitable site found
HOMEPAGE="http://user.it.uu.se/~andersl/emacs.shtml#folding"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc-macos ~alpha"
IUSE=""

SITEFILE="70${PN}-gentoo.el"
