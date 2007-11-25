# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thinks/thinks-1.8.ebuild,v 1.10 2007/11/25 21:33:00 ulm Exp $

inherit elisp

DESCRIPTION="Insert text in a think bubble"
HOMEPAGE="http://www.davep.org/emacs/thinks.el"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
