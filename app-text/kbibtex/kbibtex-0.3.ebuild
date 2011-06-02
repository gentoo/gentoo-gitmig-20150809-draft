# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbibtex/kbibtex-0.3.ebuild,v 1.1 2011/06/02 16:18:21 scarabeus Exp $

EAPI=4


inherit versionator kde4-base

DESCRIPTION="BibTeX editor for KDE to edit bibliographies used with LaTeX"
HOMEPAGE="http://home.gna.org/kbibtex/"
SRC_URI="http://download.gna.org/${PN}/$(get_version_component_range 1-2)/${P/_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="virtual/tex-base
	dev-libs/libxml2
	dev-libs/libxslt
"
RDEPEND="${DEPEND}
	dev-tex/bibtex2html"

S=${WORKDIR}/${P/_/-}
