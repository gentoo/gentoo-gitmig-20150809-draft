# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/leaflet/leaflet-19990601.ebuild,v 1.4 2004/06/25 02:15:48 agriffis Exp $

inherit latex-package

S=${WORKDIR}/leaflet
DESCRIPTION="LaTeX package used to create leaflet-type brochures."
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="ftp://ibiblio.org/pub/packages/TeX/macros/latex/contrib/supported/"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""

# checksum from official ftp site changes frequently so we mirror it

