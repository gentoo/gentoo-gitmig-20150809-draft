# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reportlab/reportlab-1.17.ebuild,v 1.1 2003/07/04 12:16:11 liquidx Exp $

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
	dev-python/Imaging"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~sparc ~alpha"

src_compile() {
	cp ${FILESDIR}/${PV}/setup.py .        
	python setup.py build
}
	
src_install() {
	python setup.py install --root=${D}
	dodoc  README license.txt docs/*
}




