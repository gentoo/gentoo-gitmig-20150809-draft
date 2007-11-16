# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/iconkit/iconkit-0.2.ebuild,v 1.4 2007/11/16 15:05:53 beandog Exp $

inherit gnustep-2

S="${WORKDIR}/Etoile-${PV}/Frameworks/IconKit"

DESCRIPTION="framework used to create icons using different elements"
HOMEPAGE="http://www.etoile-project.org"
SRC_URI="http://download.gna.org/etoile/etoile-${PV}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc x86"
SLOT="0"

DEPEND="media-libs/libpng"
RDEPEND="${DEPEND}"
