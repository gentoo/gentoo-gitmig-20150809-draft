# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soappy/soappy-0.11.6-r1.ebuild,v 1.6 2008/01/17 17:53:59 grobian Exp $

inherit distutils eutils

MY_P="SOAPpy-${PV}"

DESCRIPTION="SOAP implementation for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="BSD"
IUSE=""

DEPEND=">=dev-python/fpconst-0.7.1
		dev-python/pyxml"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-python-2.5-compat.patch"
}
