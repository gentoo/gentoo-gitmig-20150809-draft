# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/ReportLab/ReportLab-1.14.ebuild,v 1.3 2002/08/16 02:49:58 murphy Exp $

#goofy tarball versioning
vmaj=${PV%%.*}
vmin=${PV##*.}

S=${WORKDIR}/reportlab
DESCRIPTION="Tools for generating printable PDF documents from any data source."
SRC_URI="http://www.reportlab.com/ftp/${PN}_${vmaj}_${vmin}.tgz"
HOMEPAGE="http://www.reportlab.com/"

DEPEND=">=dev-lang/python-1.5"
RDEPEND="${DEPEND}
	>=sys-libs/zlib-0.95
	dev-python/Imaging"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	cp ${FILESDIR}/${PV}/setup.py .        
	python setup.py build
}
	
src_install() {
	python setup.py install --root=${D}
	dodoc  README license.txt docs/*
}




