# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/extsizes/extsizes-1.0.ebuild,v 1.2 2004/07/01 11:52:39 dholm Exp $

inherit latex-package

DESCRIPTION="Provide ext{book,article,proc} styles which allow 14pt-20pt sizes"
HOMEPAGE="http://tex.imm.uran.ru/texserver/style/14-20pt/example/index.html"
SRC_URI="http://tex.imm.uran.ru/texserver/style/14-20pt/14-20pt.zip"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
S=${WORKDIR}/14PT

src_install() {
	latex-package_src_doinstall all
	dodoc ${S}/readme.extsizes
}
