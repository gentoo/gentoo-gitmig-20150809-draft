# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/uniconvertor/uniconvertor-1.1.5.ebuild,v 1.1 2010/08/06 13:43:59 jlec Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7 3.*"

inherit distutils

DESCRIPTION="Commandline tool for popular vector formats convertion"
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://uniconvertor.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE=""

DEPEND="
	dev-python/imaging
	dev-python/reportlab
	>=media-libs/sk1libs-0.9.1"

S=${WORKDIR}/${P}

src_prepare() {
	sed -i \
		-e "s/'GNU_GPL_v2', 'GNU_LGPL_v2', 'COPYRIGHTS',//" \
		setup.py || die

	distutils_src_prepare
}

src_install() {
	distutils_src_install
}
