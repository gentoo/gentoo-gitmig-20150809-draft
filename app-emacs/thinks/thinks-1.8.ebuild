# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thinks/thinks-1.8.ebuild,v 1.2 2004/06/01 14:09:05 vapier Exp $

inherit elisp

DESCRIPTION="Insert text in a think bubble."
HOMEPAGE="http://www.davep.org/emacs/thinks.el"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/${P}

SITEFILE=50thinks-gentoo.el
