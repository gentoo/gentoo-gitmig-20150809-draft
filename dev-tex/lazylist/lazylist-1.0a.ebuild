# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/lazylist/lazylist-1.0a.ebuild,v 1.7 2004/12/28 21:10:03 absinthe Exp $

inherit latex-package

DESCRIPTION="Lists in TeX's mouth - lambda-calculus and list-handling macros"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/lazylist/"
# originally from:
#SRC_URI="http://www.ctan.org/tex-archive/macros/latex/contrib/lazylist/*"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE=""
DEPEND=""
#RDEPEND=""
S="${WORKDIR}/${PN}"


