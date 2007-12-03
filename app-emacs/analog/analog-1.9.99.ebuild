# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/analog/analog-1.9.99.ebuild,v 1.1 2007/12/03 07:49:38 opfer Exp $

inherit elisp

DESCRIPTION="Monitor lists of files or command output"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?action=browse&id=MattHodges&oldid=MatthewHodges"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SIMPLE_ELISP="t"

SITEFILE=50${PN}-gentoo.el
