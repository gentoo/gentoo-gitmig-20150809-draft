# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/latex-leaflet/latex-leaflet-19990601.ebuild,v 1.10 2003/02/28 13:18:14 liquidx Exp $

inherit latex-package

S=${WORKDIR}/leaflet
DESCRIPTION="LaTeX package used to create leaflet-type brochures."
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="ftp://ibiblio.org/pub/packages/TeX/macros/latex/contrib/supported/"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86 sparc "

# checksum from official ftp site changes frequently so we mirror it

