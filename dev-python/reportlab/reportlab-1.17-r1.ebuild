# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reportlab/reportlab-1.17-r1.ebuild,v 1.1 2003/07/04 12:16:11 liquidx Exp $

#goofy tarball versioning
vmaj=${PV%%.*}
vmin=${PV##*.}

inherit distutils

S=${WORKDIR}/${PN}
DESCRIPTION="Tools for generating printable PDF documents from any data source."
SRC_URI="http://www.reportlab.com/ftp/ReportLab_${vmaj}_${vmin}.tgz"
HOMEPAGE="http://www.reportlab.com/"

DEPEND="virtual/python
	>=sys-libs/zlib-0.95
	dev-python/Imaging
	sys-apps/sed-4"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~alpha"

src_install() {
	distutils_python_version
	distutils_src_install
	
	# crube hack to fix data files in the right dir
	cd ${D}/usr/lib/python${PYVER}
	tar -cv reportlab | tar -C ${D}/usr/lib/python${PYVER}/site-packages -x
	rm -rf ${D}/usr/lib/python${PYVER}/reportlab

	# docs
	cd ${S}
	dodoc README license.txt 
	insinto /usr/share/doc/${PF}
	doins docs/*
}
