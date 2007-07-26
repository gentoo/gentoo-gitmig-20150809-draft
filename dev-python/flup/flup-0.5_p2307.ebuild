# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flup/flup-0.5_p2307.ebuild,v 1.5 2007/07/26 18:15:47 corsair Exp $

NEED_PYTHON=2.4

inherit distutils versionator

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"

MY_PV=$(get_version_component_range 3-)
MY_P=${PN}-r${MY_PV/p}

DESCRIPTION="Random assortment of WSGI servers, middleware"
HOMEPAGE="http://www.saddi.com/software/flup/"
SRC_URI="http://www.saddi.com/software/${PN}/dist/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
