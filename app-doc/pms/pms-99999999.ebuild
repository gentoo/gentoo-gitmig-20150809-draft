# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/pms/pms-99999999.ebuild,v 1.4 2008/09/29 13:31:18 fmccor Exp $

inherit git

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/pms.git"

DESCRIPTION="Gentoo Package Manager Specification (draft)"
HOMEPAGE="http://www.gentoo.org/proj/en/qa/pms.xml"
SRC_URI=""

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~sparc"
IUSE="all-options html kdebuild"

DEPEND="html? ( dev-tex/tex4ht )
	dev-texlive/texlive-latex
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-science"
RDEPEND=""

set_conditional() {
	local boolname=ENABLE-$(tr '[[:lower:]]' '[[:upper:]]' <<<${1})
	local boolval=$(use ${1} && echo true || echo false)
	sed -i -e '/\\setboolean{'${boolname}'}/s/true\|false/'${boolval}'/' pms.tex || die "sed failed"
}

src_compile() {
	set_conditional all-options
	set_conditional kdebuild

	emake || die "emake failed"
	if use html; then
		emake html || die "emake html failed"
	fi
}

src_install() {
	dodoc pms.pdf || die "dodoc failed"
	if use html; then
		dohtml *.html pms.css $(shopt -s nullglob; echo *.png) || die "dohtml failed"
	fi
}
