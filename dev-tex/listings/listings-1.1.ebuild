# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/listings/listings-1.1.ebuild,v 1.1 2003/09/19 17:21:51 obz Exp $

inherit latex-package

S=${WORKDIR}

DESCRIPTION="A source code and pretty print package for LaTeX"
SRC_URI="http://www.atscire.de/products/listings/${P}.zip"
HOMEPAGE="http://www.atscire.de/products/listings"
LICENSE="LPPL-1.2"

IUSE=""
SLOT="0"
KEYWORDS="~x86"

# these functions are overridden from the base class because
# we need to do docs things using texi2dvi in
# /var/cache/fonts
src_install() {

	cd ${S}
	latex-package_src_doinstall styles fonts pdf

}

pkg_postinst() {

	cd ${S}
	latex-package_src_doinstall dtx
	latex-package_pkg_postinst

}

