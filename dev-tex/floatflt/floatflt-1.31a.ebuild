# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/floatflt/floatflt-1.31a.ebuild,v 1.11 2006/12/03 19:12:19 nattfodd Exp $

inherit latex-package

S=${WORKDIR}/floatflt

DESCRIPTION="LaTeX package used to warp text around figures"
SRC_URI="ftp://ftp.dante.de/tex-archive/macros/latex/contrib/other/${PN}.tar.gz"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/floatflt.html?action=/tex-archive/macros/latex/contrib/other/floatflt/"

LICENSE="LPPL-1.2"
SLOT="0"

KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

# >=tetex-2.96 contains floatflt package
DEPEND="!>=app-text/tetex-2.96"
