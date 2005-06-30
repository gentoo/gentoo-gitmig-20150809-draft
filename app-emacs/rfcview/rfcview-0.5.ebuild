# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rfcview/rfcview-0.5.ebuild,v 1.7 2005/06/30 15:18:58 mkennedy Exp $

inherit elisp

DESCRIPTION="rfcview.el is a small Emacs add-on that reformats IETF RFCs for display"
HOMEPAGE="http://www.neilvandyke.org/rfcview/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc-macos ~amd64"
IUSE=""

SITEFILE=50rfcview-gentoo.el
