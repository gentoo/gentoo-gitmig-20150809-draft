# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/g-brief/g-brief-4.0.1.ebuild,v 1.9 2005/04/03 06:04:56 j4rg0n Exp $

inherit latex-package

S=${WORKDIR}/${PN}

# checksum from official ftp site changes frequently so we mirror it
DESCRIPTION="LaTeX styles for formless letters in German or English."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/g-brief/"
LICENSE="LPPL-1.2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ppc amd64 ~sparc ~alpha ~ppc-macos"

DEPEND="!>=app-text/tetex-2.96"

# we dont need to regenerate the dvis, they come
# in the archive, see bug #28240. <obz@gentoo.org>
src_install() {

	latex-package_src_doinstall styles

	dodir /usr/share/doc/${P}
	cp *.dvi ${D}/usr/share/doc/${P}

}
