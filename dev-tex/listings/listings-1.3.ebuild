# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/listings/listings-1.3.ebuild,v 1.1 2004/09/08 17:38:50 usata Exp $

inherit latex-package

S=${WORKDIR}

DESCRIPTION="A source code and pretty print package for LaTeX"
#SRC_URI="http://www.atscire.de/index.php?nav=download\&file=${P}.zip"
#RESTRICT="nomirror"
SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="http://www.atscire.de/products/listings"
LICENSE="LPPL-1.2"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

# these functions are overridden from the base class because
# we need to do docs things using texi2dvi in
# /var/cache/fonts
src_install() {

	addwrite /var/cache/fonts
	latex-package_src_doinstall styles fonts pdf dtx

}
