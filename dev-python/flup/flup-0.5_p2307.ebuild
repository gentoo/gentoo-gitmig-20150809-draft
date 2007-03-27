# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flup/flup-0.5_p2307.ebuild,v 1.2 2007/03/27 16:27:44 armin76 Exp $

inherit distutils versionator

KEYWORDS="~amd64 ~ia64 ~x86"

MY_PV=$(get_version_component_range 3-)
MY_P=${PN}-r${MY_PV/p}

DESCRIPTION="Random assortment of WSGI servers, middleware"
HOMEPAGE="http://www.saddi.com/software/flup/"
SRC_URI="http://www.saddi.com/software/${PN}/dist/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/setuptools-0.6_rc3"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/use_setuptools/d' \
		setup.py || die "sed failed"
}
