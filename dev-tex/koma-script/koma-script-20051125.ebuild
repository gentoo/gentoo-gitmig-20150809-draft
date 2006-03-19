# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/koma-script/koma-script-20051125.ebuild,v 1.3 2006/03/19 23:53:37 halcy0n Exp $

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX package with german adaptions of common (english) classes"
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/koma-script.html"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""

RDEPEND="!>=app-text/tetex-3.0"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_compile() {
	make -f Makefile.unx || die
}

src_install () {
	dodir /usr/share/doc/${PF}
	yes | make -f Makefile.unx \
		INSTALLTEXMF=${D}/usr/share/texmf \
		DOCDIR=${D}/usr/share/doc/${PF} \
		TEXHASH="" install || die
}
