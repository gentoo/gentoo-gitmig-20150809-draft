# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reportlab/reportlab-1.14.ebuild,v 1.5 2004/07/19 22:04:27 kloeri Exp $

#goofy tarball versioning
vmaj=${PV%%.*}
vmin=${PV##*.}

S=${WORKDIR}/${PN}
DESCRIPTION="Tools for generating printable PDF documents from any data source."
SRC_URI="http://www.reportlab.com/ftp/ReportLab_${vmaj}_${vmin}.tgz"
HOMEPAGE="http://www.reportlab.com/"

DEPEND=">=dev-lang/python-1.5"
RDEPEND="${DEPEND}
	>=sys-libs/zlib-0.95
	dev-python/imaging"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc alpha"
IUSE=""

src_compile() {
	cp ${FILESDIR}/${PV}/setup.py .
	python setup.py build
}

src_install() {
	python setup.py install --root=${D}
	dodoc  README license.txt docs/*
}
