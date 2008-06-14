# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/browse-kill-ring/browse-kill-ring-1.3.ebuild,v 1.2 2008/06/14 23:22:18 ulm Exp $

inherit elisp

DESCRIPTION="An improved interface to kill-ring"
HOMEPAGE="http://www.todesschaf.org/projects/bkr.html"
# taken from http://www.todesschaf.org/files/browse-kill-ring.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
