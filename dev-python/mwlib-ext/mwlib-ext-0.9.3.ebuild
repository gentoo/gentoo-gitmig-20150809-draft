# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mwlib-ext/mwlib-ext-0.9.3.ebuild,v 1.1 2009/04/18 20:34:32 patrick Exp $

NEED_PYTHON=2.4

inherit distutils

MY_PN=${PN/-/.}
MY_P=${P/-/.}

DESCRIPTION="Mediwiki parse to PDF converter - reportlab support"
HOMEPAGE="http://code.pediapress.com/wiki/wiki"
SRC_URI="http://pypi.python.org/packages/source/m/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=">=dev-python/pygments-0.10"

S=$WORKDIR/$MY_P

src_install() {
	distutils_src_install
}
