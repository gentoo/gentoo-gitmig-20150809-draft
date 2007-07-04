# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyprotocols/pyprotocols-1.0_pre2082.ebuild,v 1.2 2007/07/04 18:52:29 pythonhead Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=PyProtocols
MY_P=${MY_PN}-${PV/_pre/a0dev_r}

DESCRIPTION="Extends the PEP 246 adapt() function with a new 'declaration API' that lets you easily define your own protocols and adapters, and declare what adapters should be used to adapt what types, objects, or protocols."
HOMEPAGE="http://peak.telecommunity.com/PyProtocols.html"
SRC_URI="http://peak.telecommunity.com/snapshots/${MY_P}.zip"
LICENSE="|| ( PSF-2.4 ZPL )"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools
	app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="protocols"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/ez_setup/d' \
		setup.py || die "sed failed"
}
