# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/foiltex/foiltex-2.1.3.ebuild,v 1.6 2004/08/17 23:23:28 usata Exp $

inherit latex-package

S=${WORKDIR}/foiltex
DESCRIPTION="LaTeX package used to create foils and slides"
SRC_URI="ftp://ftp.dante.de/tex-archive/macros/latex/contrib/supported/foiltex.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/foiltex.html"
LICENSE="as-is"
#for License details see /usr/share/doc/latex-foiltex-2.1.3/foiltex.ins
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

src_install () {
	latex-package_src_doinstall all
	cd ${S}
	dodoc readme.flt
}
