# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pp/pp-1.3.2.ebuild,v 1.2 2007/03/25 11:05:59 dev-zero Exp $

NEED_PYTHON=2.3

inherit distutils versionator

EX_P=${PN}-$(get_version_component_range 1-2)-examples-1.0

DESCRIPTION="Parallel and distributed programming for Python"
HOMEPAGE="http://www.parallelpython.com/"
SRC_URI="http://www.parallelpython.com/downloads/${PN}/${P}.tar.gz
	examples? ( http://www.parallelpython.com/downloads/${PN}/${EX_P}.tar.bz2 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${WORKDIR}/examples"
	fi
}
