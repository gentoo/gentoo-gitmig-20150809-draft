# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlrd/xlrd-0.7.1.ebuild,v 1.2 2010/04/16 17:35:10 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Library for developers to extract data from Microsoft Excel (tm) spreadsheet files"
HOMEPAGE="http://pypi.python.org/pypi/xlrd"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc-aix ~hppa-hpux ~ia64-hpux ~x86-interix ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	distutils_src_prepare
	# add shebang to runxlrd.py
	sed -i -e '1i#!/usr/bin/env python' scripts/runxlrd.py || die
}
