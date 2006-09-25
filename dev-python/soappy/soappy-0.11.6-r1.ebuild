# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soappy/soappy-0.11.6-r1.ebuild,v 1.1 2006/09/25 13:34:23 marienz Exp $

inherit distutils eutils

MY_P="SOAPpy-${PV}"

DESCRIPTION="SOAP implementation for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc-macos ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-python/fpconst-0.7.1
		dev-python/pyxml"

S=${WORKDIR}/${MY_P}


src_unpack() {
	unpack ${A}
	cd "${S}"

	# python 2.5 compatibility
	epatch "${FILESDIR}/${P}-future-imports.patch"
}
