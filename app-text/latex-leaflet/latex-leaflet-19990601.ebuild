# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/latex-leaflet/latex-leaflet-19990601.ebuild,v 1.5 2002/07/10 22:59:33 seemant Exp $

inherit latex-package

S=${WORKDIR}/leaflet
DESCRIPTION="LaTeX package used to create leaflet-type brochures."
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="ftp://ibiblio.org/pub/packages/TeX/macros/latex/contrib/supported/"
LICENSE="LPPL"
SLOT="0"
KEYWORDS="x86"

# checksum from official ftp site changes frequently so we mirror it

