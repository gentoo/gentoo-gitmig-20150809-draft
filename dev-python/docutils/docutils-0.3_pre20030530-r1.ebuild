# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docutils/docutils-0.3_pre20030530-r1.ebuild,v 1.1 2003/06/01 03:55:14 g2boojum Exp $

DESCRIPTION="Set of python tools for processing plaintext docs into HTML, XML, etc."
HOMEPAGE="http://docutils.sourceforge.net/"
SRC_URI="mirror://${P}.tgz"

LICENSE="public-domain PYTHON"
SLOT="0"
KEYWORDS="x86"
IUSE=""

inherit distutils

DEPEND=">=dev-lang/python-2.1"
S=${WORKDIR}/${PN}

src_install() {
	mydoc="MANIFEST.in *.txt"
	distutils_src_install
	dodoc docs/*
	dodir /usr/share/${PN}
	cp -a tools test spec ${D}/usr/share/${PN}
	pushd tools
	dobin *.py
	popd
	dobin ${FILESDIR}/glep.py
	insinto /usr/lib/python${PYVER}/site-packages/docutils/readers
	newins ${FILESDIR}/glepread.py glep.py
	insinto /usr/lib/python${PYVER}/site-packages/docutils/transforms
	newins ${FILESDIR}/glepstrans.py gleps.py
	insinto /usr/lib/python${PYVER}/site-packages/docutils/writers
	newins ${FILESDIR}/glep_htmlwrite.py glep_html.py
}

