# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/rcsinfo/rcsinfo-1.9.ebuild,v 1.1 2004/11/07 09:24:03 usata Exp $

inherit latex-package

S="${WORKDIR}/${PN}"
LICENSE="LPPL-1.2"
DESCRIPTION="A LaTeX module to acces RCS/CVS version info"
HOMEPAGE="http://www.cvsnt.org/manual/rcsinfo.html"
# downloaded from
# ftp://ftp.ctan.org/pub/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DOCS="README-1.9"
