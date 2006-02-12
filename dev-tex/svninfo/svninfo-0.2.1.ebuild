# Copyright 2005-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/svninfo/svninfo-0.2.1.ebuild,v 1.2 2006/02/12 15:52:15 nattfodd Exp $

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

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-latex-compile.patch
}

src_compile() {
	emake || die "compilation failed"
}
