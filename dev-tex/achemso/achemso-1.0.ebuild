# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/achemso/achemso-1.0.ebuild,v 1.6 2004/10/05 06:45:41 usata Exp $

inherit latex-package
S=${WORKDIR}
DESCRIPTION="LaTeX package used for formatting publications to the American Chemical Society"
SRC_URI="http://www.homenet.se/matsd/latex/${PN}.zip"
HOMEPAGE="http://www.homenet.se/matsd/latex/"
LICENSE="LPPL-1.2" #custom, LPPL-like
SLOT="0"
IUSE=""
KEYWORDS="x86 alpha ppc ~sparc"
DEPEND="app-arch/unzip"
