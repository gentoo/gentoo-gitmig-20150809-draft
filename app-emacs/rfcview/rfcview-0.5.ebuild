# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rfcview/rfcview-0.5.ebuild,v 1.5 2004/11/01 11:34:36 usata Exp $

inherit elisp

DESCRIPTION="rfcview.el is a small Emacs add-on that reformats IETF RFCs for display"
HOMEPAGE="http://www.neilvandyke.org/rfcview/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc-macos"
IUSE=""

SITEFILE=50rfcview-gentoo.el
