# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/latex-leaflet/latex-leaflet-19990601.ebuild,v 1.7 2002/10/04 05:06:24 vapier Exp $

inherit latex-package

S=${WORKDIR}/leaflet
DESCRIPTION="LaTeX package used to create leaflet-type brochures."
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="ftp://ibiblio.org/pub/packages/TeX/macros/latex/contrib/supported/"
LICENSE="LPPL"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

# checksum from official ftp site changes frequently so we mirror it

