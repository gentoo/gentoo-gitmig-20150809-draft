# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/uniconvertor/uniconvertor-1.1.0.ebuild,v 1.1 2010/01/10 14:17:36 ssuominen Exp $

EAPI=2
inherit distutils

MY_P=UniConvertor-${PV}

DESCRIPTION="UniConvertor - commandline tool for popular vector formats convertion."
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://sk1project.org/downloads/${PN}/v${PV}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE=""

DEPEND="virtual/python
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
