# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/uniconvertor/uniconvertor-1.1.4.ebuild,v 1.3 2011/03/01 15:36:32 jer Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P=UniConvertor-${PV}

DESCRIPTION="Commandline tool for popular vector formats convertion"
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://sk1project.org/downloads/${PN}/v${PV}/${P}.tar.gz"

KEYWORDS="~amd64 ~hppa ~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE=""

DEPEND="
	dev-python/imaging
	dev-python/reportlab"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e "s/'GNU_GPL_v2', 'GNU_LGPL_v2', 'COPYRIGHTS',//" \
		setup.py || die

	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dosym uniconv /usr/bin/uniconvertor || die
}
