# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thinks/thinks-1.8.ebuild,v 1.4 2004/06/24 22:25:23 agriffis Exp $

inherit elisp

DESCRIPTION="Insert text in a think bubble."
HOMEPAGE="http://www.davep.org/emacs/thinks.el"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"

SITEFILE=50thinks-gentoo.el
