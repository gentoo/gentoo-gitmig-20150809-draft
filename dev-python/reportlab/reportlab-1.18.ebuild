# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reportlab/reportlab-1.18.ebuild,v 1.2 2004/03/02 18:14:28 pbienst Exp $

#goofy tarball versioning
vmaj=${PV%%.*}
vmin=${PV##*.}

inherit python distutils

S=${WORKDIR}/${PN}
DESCRIPTION="Tools for generating printable PDF documents from any data source."
SRC_URI="http://www.reportlab.org/ftp/ReportLab_${vmaj}_${vmin}.tgz"
HOMEPAGE="http://www.reportlab.org/"

DEPEND=">=sys-libs/zlib-0.95
	dev-python/Imaging
	>=sys-apps/sed-4
	app-arch/tar"

IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

src_install() {
	python_version
	distutils_src_install

	# crude hack to fix data files in the right dir
	cd ${D}/usr/lib/python${PYVER}
	tar -cv reportlab | tar -C ${D}/usr/lib/python${PYVER}/site-packages -x
	rm -rf ${D}/usr/lib/python${PYVER}/reportlab

	# docs
	cd ${S}
	dodoc README license.txt
	insinto /usr/share/doc/${PF}
	doins docs/*
}
