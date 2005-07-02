# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/h4x0r/h4x0r-0.13.ebuild,v 1.2 2005/07/02 09:32:44 dholm Exp $

inherit elisp

IUSE=""

DESCRIPTION="Aid in writing like a script kiddie does"
HOMEPAGE="http://www.livingtorah.org/~csebold/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="virtual/emacs"

SITEFILE=50h4x0r-gentoo.el
