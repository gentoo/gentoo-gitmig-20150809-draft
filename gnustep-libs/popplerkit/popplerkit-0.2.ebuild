# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/popplerkit/popplerkit-0.2.ebuild,v 1.1 2007/09/10 14:07:31 voyageur Exp $

inherit gnustep-2

S="${WORKDIR}/Etoile-${PV}/Frameworks/PopplerKit"


DESCRIPTION="PopplerKit is a GNUstep/Cocoa framework for accessing and rendering PDF content."
HOMEPAGE="http://www.etoile-project.org"
SRC_URI="http://download.gna.org/etoile/etoile-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"

DEPEND=">=app-text/poppler-0.4
	>=media-libs/freetype-2"
RDEPEND="${DEPEND}"
