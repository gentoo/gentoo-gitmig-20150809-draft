# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/setnu/setnu-1.06.ebuild,v 1.5 2007/07/03 19:35:24 ulm Exp $

inherit elisp

DESCRIPTION="Display line numbers in Emacs buffers"
HOMEPAGE="http://www.wonderworks.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
