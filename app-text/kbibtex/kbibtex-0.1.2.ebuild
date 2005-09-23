# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbibtex/kbibtex-0.1.2.ebuild,v 1.1 2005/09/23 12:28:11 cryos Exp $

inherit kde

DESCRIPTION="BibTeX editor for KDE"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~fischer/kbibtex/"
SRC_URI="http://www.unix-ag.uni-kl.de/~fischer/kbibtex/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/tetex"

need-kde 3.3
