# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/pms/pms-99999999.ebuild,v 1.13 2010/01/10 15:13:59 fauli Exp $

inherit git

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/pms.git"

DESCRIPTION="Gentoo Package Manager Specification (draft)"
HOMEPAGE="http://www.gentoo.org/proj/en/qa/pms.xml"
SRC_URI=""

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS=""
IUSE="html"

DEPEND="html? ( >=dev-tex/tex4ht-20090115_p0029 )
	dev-tex/leaflet
	dev-texlive/texlive-bibtexextra
	dev-texlive/texlive-latex
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-science"
RDEPEND=""

src_compile() {
	emake || die
	if use html; then
		emake html || die
	fi
}

src_install() {
	dodoc pms.pdf || die
	if use html; then
		dohtml *.html pms.css $(shopt -s nullglob; echo *.png) || die
	fi
}
