# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/xkeyval/xkeyval-2.5f.ebuild,v 1.6 2008/01/05 11:21:51 aballier Exp $

inherit latex-package

DESCRIPTION="xkeyval is an extension of the keyval package."
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/xkeyval.html"
SRC_URI="ftp://tug.ctan.org/tex-archive/macros/latex/contrib/${PN}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos x86"
IUSE="doc"
RDEPEND=">=app-text/tetex-3.0"
DEPEND="${RDEPEND}
	app-arch/unzip"

TEXMF="/usr/share/texmf-site"
S=${WORKDIR}/${PN}

src_install() {
	insinto ${TEXMF}/tex/generic/${PN}
	doins "${S}"/run/{keyval,pst-xkey,xkeyval,xkvtxhdr}.tex
	insinto ${TEXMF}/tex/latex/${PN}
	doins "${S}"/run/{pst-xkey,xkeyval,xkvview,xkvltxp}.sty

	cd "${S}"
	dodoc README

	if use doc ; then
		cd "${S}"/doc
		latex-package_src_doinstall doc
	fi
}
