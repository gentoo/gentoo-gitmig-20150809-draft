# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/leaflet/leaflet-19990601.ebuild,v 1.6 2007/02/06 16:52:17 nattfodd Exp $

inherit latex-package

S=${WORKDIR}/leaflet
DESCRIPTION="LaTeX package used to create leaflet-type brochures."
SRC_URI="mirror:///gentoo/${P}.tar.gz"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/leaflet/"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86 sparc amd64"
IUSE=""

# checksum from official ftp site changes frequently so we mirror it

