# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/vindaloo/vindaloo-0.2-r1.ebuild,v 1.1 2007/09/10 14:21:22 voyageur Exp $

inherit gnustep-2

S="${WORKDIR}/Etoile-${PV}/Services/User/${PN/v/V}"

DESCRIPTION="An Application for displaying and navigating in PDF documents."
HOMEPAGE="http://www.etoile-project.org"
SRC_URI="http://download.gna.org/etoile/etoile-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86 ~amd64"
SLOT="0"

DEPEND="gnustep-libs/popplerkit
	gnustep-libs/iconkit"
RDEPEND="${DEPEND}"
