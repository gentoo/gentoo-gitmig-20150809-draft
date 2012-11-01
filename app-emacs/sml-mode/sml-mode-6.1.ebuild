# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sml-mode/sml-mode-6.1.ebuild,v 1.1 2012/11/01 14:42:24 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="Emacs major mode for editing Standard ML"
HOMEPAGE="http://www.iro.umontreal.ca/~monnier/elisp/"
# taken from http://bzr.sv.gnu.org/r/emacs/elpa
SRC_URI="mirror://gentoo/${P}.el.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"

DEPEND="app-arch/xz-utils"

SITEFILE="50${PN}-gentoo.el"
