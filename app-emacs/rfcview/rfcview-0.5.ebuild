# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rfcview/rfcview-0.5.ebuild,v 1.1 2003/10/31 22:34:09 mkennedy Exp $

inherit elisp

DESCRIPTION="rfcview.el is a small Emacs add-on that reformats IETF RFCs for display"
HOMEPAGE="http://www.neilvandyke.org/rfcview/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/${P}

SITEFILE=50rfcview-gentoo.el
