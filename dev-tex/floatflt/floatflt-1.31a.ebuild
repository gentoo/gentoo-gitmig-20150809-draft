# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/floatflt/floatflt-1.31a.ebuild,v 1.8 2004/11/07 05:53:58 usata Exp $

inherit latex-package

S=${WORKDIR}/floatflt

DESCRIPTION="LaTeX package used to warp figures around text"
SRC_URI="ftp://ftp.dante.de/tex-archive/macros/latex/contrib/other/${PN}.tar.gz"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/floatflt.html?action=/tex-archive/macros/latex/contrib/other/floatflt/"

LICENSE="LPPL-1.2"
SLOT="0"

KEYWORDS="x86 ppc sparc ~amd64 ~alpha"
IUSE=""

# >=tetex-2.96 contains floatflt package
DEPEND="!>=app-text/tetex-2.96"
