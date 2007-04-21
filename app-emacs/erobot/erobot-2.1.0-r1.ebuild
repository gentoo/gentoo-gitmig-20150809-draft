# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erobot/erobot-2.1.0-r1.ebuild,v 1.1 2007/04/21 08:36:19 ulm Exp $

inherit elisp

DESCRIPTION="Battle-bots for Emacs!"
HOMEPAGE="http://www.geocities.com/kensanata/emacs-games.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el
