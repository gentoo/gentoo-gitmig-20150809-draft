# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/browse-kill-ring/browse-kill-ring-1.3.ebuild,v 1.3 2010/03/18 19:10:06 fauli Exp $

inherit elisp

DESCRIPTION="An improved interface to kill-ring"
HOMEPAGE="http://www.todesschaf.org/projects/bkr"
# taken from http://www.todesschaf.org/files/browse-kill-ring.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
