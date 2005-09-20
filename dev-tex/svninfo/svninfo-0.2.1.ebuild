# Copyright 2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/svninfo/svninfo-0.2.1.ebuild,v 1.1 2005/09/20 20:41:39 carpaski Exp $

inherit latex-package

S="${WORKDIR}/${PN}"
LICENSE="LPPL-1.2"
DESCRIPTION="A LaTeX module to acces SVN version info"
HOMEPAGE="http://tug.ctan.org/tex-archive/macros/latex/contrib/svninfo/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DOCS="README svninfo.pdf"
