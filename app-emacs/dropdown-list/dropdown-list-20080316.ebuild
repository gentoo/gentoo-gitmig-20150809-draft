# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/dropdown-list/dropdown-list-20080316.ebuild,v 1.1 2008/06/19 12:13:25 ulm Exp $

inherit elisp

DESCRIPTION="Drop-down menu interface"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/dropdown-list.el"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
