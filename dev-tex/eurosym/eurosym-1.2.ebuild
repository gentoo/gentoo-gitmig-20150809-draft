# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Felix Kurth <felix@fkurth.de>

inherit latex-package
S=${WORKDIR}/eurosym
DESCRIPTION="LaTeX package and fonts used to set the euro (currency) symbol."
SRC_URI="ftp://ftp.dante.de/tex-archive/fonts/eurosym.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/eurosym.html"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
SUPPLIER="public"

src_install() {
    cd ${S}
	cd src
    latex-package_src_doinstall all
    cd ${S}
	cd tfm
    latex-package_src_doinstall all
	cd ${S}
	cd sty
    latex-package_src_doinstall all
	cd ${S}
	insinto ${TEXMF}/fonts/type1/${SUPPLIER}/latex-eurosym
	doins contrib/type1/fonts/type1/eurosym/*
	insinto ${TEXMF}/dvips/config/
	doins contrib/type1/dvips/eurosym.map
	cd ${S}
	dodoc README Changes 
	cd doc
	dodoc *
 }

pkg_postinst() {
	latex-package_pkg_postinst
    einfo ""
	einfo "Please edit \"/usr/share/texmf/dvips/config/updmap\" and"
	einfo "add \"eurosym.map\" on line 24 (extra_modules)"
	einfo "Then run \"/usr/share/texmf/dvips/config/updmap\""
	einfo ""
}
