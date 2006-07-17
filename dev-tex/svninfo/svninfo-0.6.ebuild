# Copyright 2005-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/svninfo/svninfo-0.6.ebuild,v 1.2 2006/07/17 10:45:32 cryos Exp $

inherit latex-package eutils

LICENSE="LPPL-1.2"
DESCRIPTION="A LaTeX module to acces SVN version info"
HOMEPAGE="http://www.brucker.ch/projects/svninfo/index.en.html"
SRC_URI="http://www.brucker.ch/projects/svninfo/download/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DOCS="README svninfo.pdf"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.5-latex-compile.patch
}

src_compile() {
	emake -j1 || die "compilation failed"
}
